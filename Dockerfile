FROM ruby:2.6.5-alpine
MAINTAINER UCPD Cross Justice Delivery

# build dependencies:
#   - virtual: create virtual package for later deletion
#   - build-base for alpine fundamentals
#   - libxml2-dev/libxslt-dev for nokogiri, at least
#   - postgresql-dev for pg/activerecord gems
#   - git for installing gems referred to use a git:// uri
#
RUN apk --no-cache add --virtual build-deps \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  git \
  bash \
  curl \
&& apk --no-cache add \
  postgresql-client \
  linux-headers \
  xz-libs \
  tzdata \
  nodejs \
  yarn

# Install dependencies for wkhtmltopdf and microsoft fonts
RUN apk --no-cache add \
  libx11 \
  libxrender \
  libxext \
  fontconfig \
  ttf-ubuntu-font-family \
&& apk --no-cache add --virtual fonts-deps \
  msttcorefonts-installer \
&& update-ms-fonts && fc-cache -f

# ensure everything is executable
RUN chmod +x /usr/local/bin/*

# add non-root user and group with alpine first available uid, 1000
RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

# create app directory in conventional, existing dir /usr/src
RUN mkdir -p /usr/src/app && mkdir -p /usr/src/app/tmp
WORKDIR /usr/src/app

COPY Gemfile* ./

RUN gem install bundler -v 1.17.3 && \
    bundle config --global without test:development && \
    bundle install --frozen --jobs 2 --retry 3

COPY . .

# The following are ENV variables that need to be present by the time
# the assets pipeline run, but doesn't matter their value.
#
ENV EXTERNAL_URL            replace_this_at_build_time
ENV SECRET_KEY_BASE         replace_this_at_build_time
ENV GOVUK_NOTIFY_API_KEY    replace_this_at_build_time

RUN bundle exec rake assets:precompile

# tidy up installation
RUN apk del build-deps fonts-deps && rm -rf /tmp/*

# non-root/appuser should own only what they need to
RUN chown -R appuser:appgroup log tmp db

# Download RDS certificates bundle -- needed for SSL verification
# We set the path to the bundle in the ENV, and use it in `/config/database.yml`
#
ENV RDS_COMBINED_CA_BUNDLE /usr/src/app/config/rds-combined-ca-bundle.pem
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem $RDS_COMBINED_CA_BUNDLE
RUN chmod +r $RDS_COMBINED_CA_BUNDLE

ARG APP_BUILD_DATE
ENV APP_BUILD_DATE ${APP_BUILD_DATE}

ARG APP_BUILD_TAG
ENV APP_BUILD_TAG ${APP_BUILD_TAG}

ARG APP_GIT_COMMIT
ENV APP_GIT_COMMIT ${APP_GIT_COMMIT}

ENV RAILS_ENV production
ENV PUMA_PORT 3000

ENV APPUID 1000
USER $APPUID

EXPOSE $PUMA_PORT
ENTRYPOINT ["./run.sh"]
