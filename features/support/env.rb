require 'phantomjs'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'dotenv/load'
require 'uri'

#Capybara.app_host = ENV.fetch('EXTERNAL_URL')
#Capybara.server_port = URI.parse(Capybara.app_host).port
if ENV.fetch('TRAVIS', false) == 'true'
  Capybara.run_server = true
  Capybara.app_host = "http://localhost:80123"
  Capybara.server_port = "80123"
else
  Capybara.run_server = false
  Capybara.app_host = ENV.fetch('EXTERNAL_URL')
end
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

options = {
  js_errors: false,
  phantomjs: Phantomjs.path
}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end
