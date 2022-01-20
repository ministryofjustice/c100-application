FROM ruby:2.7.5-slim-buster
MAINTAINER HMCTS Reform Team

# build dependencies:
#   - virtual: create virtual package for later deletion
#   - build-base for alpine fundamentals
#   - libxml2-dev/libxslt-dev for nokogiri, at least
#   - postgresql-dev for pg/activerecord gems
#   - git for installing gems referred to use a git:// uri
#
RUN apt-get update
RUN apt-get -y install \
  build-essential \
  libxml2-dev \
  libxslt-dev \
  postgresql \
  libpq-dev \
  dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
  gettext libz-dev libssl-dev \
  bash \
  curl \
  shared-mime-info \
  xz-utils \
  nodejs \
  yarn
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

RUN gem install bundler -v 2.1.4 && \
    bundle config set frozen 'true' && \
    bundle config without test:development && \
    bundle install --jobs 2 --retry 3

COPY . .

# The following are ENV variables that need to be present by the time
# the assets pipeline run, but doesn't matter their value.
#
ENV EXTERNAL_URL=replace_this_at_build_time
ENV SECRET_KEY_BASE=replace_this_at_build_time
ENV GOVUK_NOTIFY_API_KEY=replace_this_at_build_time

ENV RAILS_ENV=production
RUN bundle exec rake assets:precompile

# Copy fonts and images (without digest) along with the digested ones,
# as there are some hardcoded references in the `govuk-frontend` files
# that will not be able to use the rails digest mechanism.
RUN cp node_modules/govuk-frontend/govuk/assets/fonts/*  public/assets/govuk-frontend/govuk/assets/fonts
RUN cp node_modules/govuk-frontend/govuk/assets/images/* public/assets/govuk-frontend/govuk/assets/images

# tidy up installation
RUN rm -rf /tmp/*

# non-root/appuser should own only what they need to
RUN chown -R appuser:appgroup log tmp db

# Download RDS certificates bundle -- needed for SSL verification
# We set the path to the bundle in the ENV, and use it in `/config/database.yml`
#
ENV RDS_COMBINED_CA_BUNDLE=/usr/src/app/config/rds-combined-ca-bundle.pem
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem $RDS_COMBINED_CA_BUNDLE
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
