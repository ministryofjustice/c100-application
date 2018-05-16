require 'phantomjs'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'dotenv/load'
require 'uri'

#Capybara.app_host = ENV.fetch('EXTERNAL_URL')
#Capybara.server_port = URI.parse(Capybara.app_host).port
if false && ENV.fetch('TRAVIS', false) == 'true'
  Capybara.run_server = true
  Capybara.app_host = "http://127.0.0.1:8123"
  Capybara.server_port = "8123"
  Capybara.always_include_port = true
else
  Capybara.run_server = false
  Capybara.app_host = ENV.fetch('EXTERNAL_URL')
end
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

puts "Capybara.app_host = #{Capybara.app_host}"
options = {
  js_errors: false,
  phantomjs_options: ['--disk-cache=true'],
#  phantomjs: Phantomjs.path
}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end
