require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'capybara/dsl'
# require 'capybara/rspec'
# require 'turnip/capybara'
require_relative 'pages/login'
require_relative 'pages/home'
# require_relative 'spec/steps/user_login_steps'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'
