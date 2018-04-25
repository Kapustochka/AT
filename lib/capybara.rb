require 'capybara'
require 'capybara/dsl'
require_relative 'capybara_help_methods'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'

# Tests steps
class Tests
  def initialize
    @t = MyCapybaraTest::TestMethods.new
  end

  def tc_01
    @t.visit('/')
    @t.click_link('Login')
    @t.check_current_uri('http://demoapp.strongqa.com/users/sign_in')
  end
  alias open_page_via_menu tc_01

  def tc_02
    @t.visit('/users/sign_in')
    @t.test_login('admin@strongqa.com', '1234567890')
    @t.check_current_uri('http://demoapp.strongqa.com/')
    raise '"Signed successfully" record wasn\'t found' unless
    @t.find('#flash_notice').text == 'Signed in successfully.'
    Capybara.reset_sessions!
  end
  alias login_with_correct_creds tc_02

  def tc_03_01
    @t.visit('/users/sign_in')
    @t.check('Remember me')
    @t.test_login('admin@strongqa.com', '1234567890')
    raise '"Signed successfully" record wasn\'t found' unless
    @t.find('#flash_notice').text == 'Signed in successfully.'
  end
  alias login_rememb_creds tc_03_01

  def tc_03_02
    @t.page.execute_script 'window.close();'
    @t.visit('/')
    raise 'Unloggined' unless @t.loginned?
  end
  alias login_rememb_creds_p2 tc_03_02

  def tc_03_03
    @t.click_link('Logout')
    @t.page.execute_script 'window.close();'
    @t.visit('/')
    raise 'Loggined' if @t.loginned?
    @t.public_sleep 5
  end
  alias login_rememb_creds_p3 tc_03_03

  def tc_04_01
    @t.visit('/users/sign_in')
    @t.test_login('admin@strongqa.com', '')
    raise 'User loggined without password' unless
    @t.find('#flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_without_passwd tc_04_01

  def tc_04_02
    @t.visit('/users/sign_in')
    @t.test_login('', '12345678')
    raise 'User loggined without mail' unless
    @t.find('#flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_without_mail tc_04_02

  def tc_04_03
    @t.visit('/users/sign_in')
    @t.test_login('', '')
    raise 'User loggined without creds' unless
    @t.find('#flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_without_creds tc_04_03

  def tc_05_01
    @t.visit('/users/sign_in')
    @t.test_login('smaximkalavrenenko@gmail.com', '1234567890')
    raise 'User loggined with wrong mail' unless
    @t.find('#flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_with_inc_mail tc_05_01

  def tc_05_02
    @t.visit('/users/sign_in')
    @t.test_login('admin@strongqa.com', '123456789')
    raise 'User loggined with wrong password' unless
    @t.find('#flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_with_inc_passwd tc_05_02

  def tc_05_03
    @t.visit('/users/sign_in')
    @t.test_login('smaximkalavrenenko@gmail.com', '123456789')
    raise 'User loggined with wrong password and mail' unless
    @t.find('#flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_with_inc_creds tc_05_03
end
