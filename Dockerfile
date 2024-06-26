#FROM hmctspublic.azurecr.io/imported/library/ruby:3.2.2-slim-buster
FROM ruby:3.2.2-slim-buster

# build dependencies:
#   - ruby-full libjpeg62-turbo libpng16-16 libxrender1 libfontconfig1 libxext6 for wkhtmltopdf
#   - libxml2-dev/libxslt-dev for nokogiri, at least
#   - postgresql-dev for pg/activerecord gems
#   - git for installing gems referred to use a git:// uri
#
RUN apt-get update
RUN apt-get -y install \
  build-essential \
  ruby-full \
  libxml2-dev \
  libxslt-dev \
  libjpeg-dev \
  libpng16-16 \
  libxrender1 \
  libfontconfig1 \
  libxext6 \
  postgresql \
  postgresql-client \
  libpq5 \
  libgmp3-dev \
  libpq-dev \
  dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
  gettext libz-dev libssl-dev \
  bash \
  curl \
  shared-mime-info \
  xz-utils \
  nodejs \
  clamav \
  clamav-daemon

RUN freshclam
RUN mkdir -p var/run/clamav && \
 chmod -R 777 /var/run/clamav && \
 mkdir -p var/log/clamav && \
 chmod -R 777 /var/log/clamav && \
 mkdir -p var/lib/clamav

# Install Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
  echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

# Install dependencies for wkhtmltopdf and microsoft fonts
RUN apt-get -y install \
  fontconfig \
  fonts-freefont-ttf

# ensure everything is executable
RUN chmod +x /usr/local/bin/*

# add non-root user and group with first available uid, 1000
RUN addgroup --gid 1000 --system appgroup && \
    adduser --uid 1000 --system appuser --ingroup appgroup

# create app directory in conventional, existing dir /usr/src
RUN mkdir -p /usr/src/app && mkdir -p /usr/src/app/tmp
WORKDIR /usr/src/app

COPY Gemfile* .ruby-version ./

RUN yarn

# "chmod -R" is due to:
# https://github.com/mileszs/wicked_pdf/issues/911
RUN gem install bundler -v 2.3.17 && \
    bundle config set frozen 'true' && \
    bundle config without test:development && \
    bundle install --jobs 2 --retry 3 && \
    chmod -R 777 /usr/local/bundle/gems/wkhtmltopdf-binary-0.12.6.6/bin

COPY . .

RUN yarn install --production --frozen-lockfile

# The following are ENV variables that need to be present by the time
# the assets pipeline run, but doesn't matter their value.
#
ENV EXTERNAL_URL=replace_this_at_build_time
ENV SECRET_KEY_BASE=replace_this_at_build_time
ENV GOVUK_NOTIFY_API_KEY=replace_this_at_build_time
ENV AWS_S3_ACCESS_KEY_ID=replace_this_at_build_time
ENV AWS_S3_SECRET_ACCESS_KEY=replace_this_at_build_time
ENV AWS_S3_REGION=eu-west-2
ENV AWS_REGION=eu-west-2
ENV AWS_S3_BUCKET=replace_this_at_build_time
ENV RAILS_ENV=production
ENV IS_DOCKER=true
ENV PRL_OPENING=false
ENV MEDIATION_DATE=29/04/2024
ENV FEE_INCREASE_DATE=01/05/2024
ENV CONFIDENTIAL_OPTION_DATE=2025/07/09T00:00:00+1
ENV PRIVACY_CHANGE=true
RUN bundle exec rake assets:precompile

# Copy fonts and images (without digest) along with the digested ones,
# as there are some hardcoded references in the `govuk-frontend` files
# that will not be able to use the rails digest mechanism.
RUN cp node_modules/govuk-frontend/govuk/assets/fonts/*  public/assets/govuk-frontend/govuk/assets/fonts
RUN cp node_modules/govuk-frontend/govuk/assets/images/* public/assets/govuk-frontend/govuk/assets/images

# tidy up installation
RUN rm -rf /tmp/*

# non-root/appuser should own only what they need to
RUN chown -R appuser:appgroup log tmp db /var/lib/clamav /var/log/clamav /var/run/clamav /etc/clamav

# Download RDS certificates bundle -- needed for SSL verification
# We set the path to the bundle in the ENV, and use it in `/config/database.yml`
#
ENV RDS_COMBINED_CA_BUNDLE=/usr/src/app/config/rds-combined-ca-bundle.pem
ADD https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem $RDS_COMBINED_CA_BUNDLE
RUN chmod +r $RDS_COMBINED_CA_BUNDLE

ARG APP_BUILD_DATE
ENV APP_BUILD_DATE=${APP_BUILD_DATE}

ARG APP_BUILD_TAG
ENV APP_BUILD_TAG=${APP_BUILD_TAG}

ARG APP_GIT_COMMIT
ENV APP_GIT_COMMIT=${APP_GIT_COMMIT}

ENV APPUID=1000
USER $APPUID

ENV PUMA_PORT=3000
EXPOSE $PUMA_PORT

ENTRYPOINT ["./run.sh"]
