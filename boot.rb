# require_relative '../boot'
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'capybara/dsl'

require_relative 'pages/login'
require_relative 'pages/home'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'
