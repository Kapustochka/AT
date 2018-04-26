
module Tests
  require 'capybara'
  require 'capybara/dsl'
  require_relative 'help_methods'

  Capybara.run_server = false
  Capybara.current_driver = :selenium
  Capybara.app_host = 'http://demoapp.strongqa.com'

  # extend Capybara::DSL
  extend HelpMethods
  class << self
    def tc(name, _description)
      puts name
      puts '-' * name.size
      # init_browser
      yield(name)
      puts "Test #{name} PASSED"
    rescue StandardError => e
      puts e.message
      # reset_browser
    end

    def tests
      tc('tc_01', 'open_page_via_menu') do |name|
        open_page '/'
        click_link_custom('Login')
        check_current_uri('http://demoapp.strongqa.com/users/sign_in')
      end

      tc('tc_02', 'login_with_correct_creds') do |name|
        open_page '/users/sign_in'
        test_login('admin@strongqa.com', '1234567890')
        check_current_uri('http://demoapp.strongqa.com/')
        assert_page_text(name, 'Signed in successfully.')
      end

      tc('tc_03', 'logout is working') do |name|
        click_link_custom('Logout')
        assert_page_text(name, 'Signed out successfully.')
      end

      tc('tc_04_1', 'prohib_log_without_passwd') do |name|
        open_page '/users/sign_in'
        test_login('admin@strongqa.com', '')
        sleep 1
        assert_page_text(name, 'Invalid email or password.')
      end

      tc('tc_04_2', 'prohib_log_without_mail') do |name|
        open_page '/users/sign_in'
        test_login('', '12345678')
        sleep 1
        assert_page_text(name, 'Invalid email or password.')
      end

      tc('tc_04_3', 'prohib_log_without_creds') do |name|
        open_page '/users/sign_in'
        test_login('', '')
        sleep 1
        assert_page_text(name, 'Invalid email or password.')
      end

      tc('tc_05_1', 'prohib_log_with_inc_mail') do |name|
        open_page '/users/sign_in'
        test_login('smaximkalavrenenko@gmail.com', '1234567890')
        sleep 1
        assert_page_text(name, 'Invalid email or password.')
      end

      tc('tc_05_2', 'prohib_log_with_inc_passwd') do |name|
        open_page '/users/sign_in'
        test_login('admin@strongqa.com', '123456789')
        sleep 1
        assert_page_text(name, 'Invalid email or password.')
      end

      tc('tc_05_3', 'prohib_log_with_inc_creds') do |name|
        open_page '/users/sign_in'
        test_login('smaximkalavrenenko@gmail.com', '123456789')
        sleep 1
        assert_page_text(name, 'Invalid email or password.')
      end
    end

  end
end

Tests.tests
