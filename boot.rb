require 'capybara'
require 'capybara/dsl'
require 'site_prism'

require_relative 'pages/login'
require_relative 'pages/home'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'
