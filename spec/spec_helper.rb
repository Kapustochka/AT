# require_relative '../boot'
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'capybara/dsl'
# require 'capybara/rspec'
# require 'turnip/capybara'
require_relative '../pages/login'
require_relative '../pages/home'
# require_relative 'spec/steps/user_login_steps'

Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'

Dir.glob('spec/steps/**/*steps.rb') { |f| load f, true }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.expose_dsl_globally = false
  # config.include UserLoginSteps
end
