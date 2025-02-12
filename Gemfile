source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.1'

gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'govuk_design_system_formbuilder'
gem 'govuk_notify_rails', '~> 3.0'
gem 'govuk-pay-ruby-client', '~> 1.0.2'
gem 'jquery-rails'
gem 'mimemagic', '~> 0.4.0'
gem 'pg', '~> 1.1'
gem 'puma', github: 'puma/puma', branch: 'master'
gem 'rails', '~> 8.0.0'
gem 'responders'
gem 'sass-rails', '< 6.0.0'
gem 'sentry-rails'
gem 'uglifier'
gem 'uk_postcode'
gem 'virtus'
gem 'parser', '~> 3.1', '>= 3.1.1.0'
gem 'tzinfo', '~> 2.0.5'
gem 'timecop'

# Back office
gem 'omniauth-auth0', '~> 3.1.0'
gem 'omniauth-rails_csrf_protection'

# Caching and jobs processing
gem 'redis'
gem "redis-actionpack"
gem 'sidekiq', '~> 7.2.0'
gem 'sidekiq_alive'

# PDF generation
gem 'combine_pdf', '~> 1.0'
gem 'wicked_pdf', '~> 2.6.0'

# Amazon S3 blob storage
gem 'aws-sdk-s3', '~> 1'
gem 'clamby'
gem 'sanitize', '~> 6.1.0'

gem 'listen'


group :development, :production do
  gem 'lograge'
  gem 'logstash-event'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'i18n-debug'
  gem "bundler-audit", "~> 0.9.1"
end

source 'https://oss:Q7U7p2q2XlpY45kwqjCpXLIPf122rjkR@gem.mutant.dev' do
  gem 'mutant-license',                '0.1.1.2.1739399027284447558325915053311580324856.7'
end

group :development, :test do
  gem 'dotenv-rails', '~> 3.1', '>= 3.1.2'
  gem 'mutant-rspec'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'web-console'
end

group :test do
  gem 'brakeman'
  gem 'capybara'
  gem 'capybara-screenshot', '~> 1.0', '>= 1.0.25'
  gem 'cucumber', '~> 9.2.0'
  gem 'cucumber-rails', require: false
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'rubocop'
  gem 'rubocop-performance', require: false
  gem 'selenium-webdriver', '>= 4.24.0'
  gem 'simplecov', require: false
  gem 'simplecov-rcov'
  gem 'site_prism', '~> 3.7', '>= 3.7.1'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'parallel_tests'
end
