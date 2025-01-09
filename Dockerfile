FROM surnet/alpine-wkhtmltopdf:3.20.2-0.12.6-small as wkhtmltopdf
FROM ruby:3.3.6-alpine3.20

# Adding argument support for ping.json
ARG APPVERSION=unknown
ARG APP_BUILD_DATE=unknown
ARG APP_GIT_COMMIT=unknown
ARG APP_BUILD_TAG=unknown

# Setting up ping.json variables
ENV APPVERSION ${APPVERSION}
ENV APP_BUILD_DATE ${APP_BUILD_DATE}
ENV APP_GIT_COMMIT ${APP_GIT_COMMIT}
ENV APP_BUILD_TAG ${APP_BUILD_TAG}

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
ENV CONFIDENTIAL_OPTION_DATE=2024/01/13T00:01:00
ENV PRIVACY_CHANGE=true


# fix to address http://tzinfo.github.io/datasourcenotfound - PET ONLY
ARG DEBIAN_FRONTEND=noninteractive

RUN apk update && apk add --no-cache libc6-compat && \
    apk add --no-cache --virtual .build-tools git build-base curl-dev nodejs yarn npm libpq-dev postgresql-client tzdata && \
    apk add --no-cache xvfb fluxbox x11vnc st shared-mime-info clamav clamav-daemon freshclam fontconfig


ENV PUMA_PORT=3000
EXPOSE $PUMA_PORT

RUN freshclam
RUN mkdir -p var/run/clamav && \
 chmod -R 777 /var/run/clamav && \
 mkdir -p var/log/clamav && \
 chmod -R 777 /var/log/clamav && \
 mkdir -p var/lib/clamav

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf

RUN gem install bundler -v 2.5.23

RUN bundle config set --local without 'test development'
RUN bundle config set force_ruby_platform true
RUN bundle install

# running app as a servive
ENV PHUSION true

COPY . /usr/src/app
RUN yarn install --check-files

ENV RDS_COMBINED_CA_BUNDLE=/usr/src/app/config/rds-combined-ca-bundle.pem
ADD https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem $RDS_COMBINED_CA_BUNDLE
RUN chmod +r $RDS_COMBINED_CA_BUNDLE

CMD ["sh", "-c", "bundle exec rake assets:precompile RAILS_ENV=production SECRET_TOKEN=blah && \
     bundle exec rake static_pages:generate RAILS_ENV=production SECRET_TOKEN=blah"]

RUN mkdir -p log

RUN mkdir -p public/assets/govuk-frontend/dist/govuk/assets/fonts && \
    cp node_modules/govuk-frontend/dist/govuk/assets/fonts/* public/assets/govuk-frontend/dist/govuk/assets/fonts/

RUN mkdir -p public/assets/govuk-frontend/dist/govuk/assets/images && \
    cp node_modules/govuk-frontend/dist/govuk/assets/images/* public/assets/govuk-frontend/dist/govuk/assets/images/

RUN cp node_modules/govuk-frontend/dist/govuk/assets/images/favicon.ico public/favicon.ico

RUN addgroup --gid 1000 --system appgroup && \
    adduser --uid 1000 --system appuser --ingroup appgroup

RUN chown -R appuser:appgroup log tmp db /var/lib/clamav /var/log/clamav /var/run/clamav /etc/clamav

ENV APPUID=1000
USER $APPUID

CMD ["sh", "./run.sh"]
