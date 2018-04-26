#  Tests
module Tests
  if !ARGV[0] || !%w[capybara selenium watir].include?(ARGV[0])
    ARGV[0] = 'capybara'
  end
  p ARGV[0]
  require_relative "lib/help_methods_#{ARGV[0]}"
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
      tc('tc_01', 'open_page_via_menu') do
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

    def selenium_demo
      tc('tc_01', 'open_page_via_menu') do
        open_page 'http://demoapp.strongqa.com'
      end
    end
  end
end

Tests.tests
# Tests.selenium_demo
