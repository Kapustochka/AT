require 'rubygems'
require 'watir'
require_relative 'watir_help_methods'


class Tests
  include TestMethods
  def initialize
    @b = Watir::Browser.new :firefox
  end

  def tc_01
    @b.goto('http://demoapp.strongqa.com')
    (@b.link text: 'Login').click
    raise 'Wrong URI' unless @b.url == 'http://demoapp.strongqa.com/users/sign_in'
  end
  alias open_page_via_menu tc_01
  def tc_02
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('admin@strongqa.com', '1234567890')
    @b.send_keys :enter
    ## TODO: Implement without sleep
    sleep 2
    raise 'Wrong URI' unless @b.url == 'http://demoapp.strongqa.com/'
    raise '"Signed successfully" record wasn\'t found' unless
    (@b.div id: 'flash_notice').text == 'Signed in successfully.'
    (@b.link text: 'Logout').click
  end
  alias login_with_correct_creds tc_02
  def tc_03_01
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('admin@strongqa.com', '1234567890')
    (@b.checkbox id: 'user_remember_me').set
    @b.send_keys :enter
    raise '"Signed successfully" record wasn\'t found' unless
    (@b.div id: 'flash_notice').text == 'Signed in successfully.'
  end
  alias login_rememb_creds tc_03_01

  def tc_03_02
    tc_03_01
    # TODO: How to close and open browser window without cookies deleting
    @b.execute_script('window.close();')
    @b.goto('http://demoapp.strongqa.com/')
    raise 'Unloggined' unless loginned?
  end
  alias login_rememb_creds_p2 tc_03_02
  def tc_03_03
    tc_03_02
    (@b.link text: 'Logout').click
    # TODO: How to close and open browser window without cookies deleting
    @b.goto('http://demoapp.strongqa.com/')
    raise 'Loggined' if loginned?
  end
  alias login_rememb_creds_p3 tc_03_03
  def tc_04_01
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('admin@strongqa.com', '')
    @b.send_keys :enter
    # @t.click_enter('#user_password')
    raise 'User loggined without password' unless
    (@b.div id: 'flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_without_passwd tc_04_01
  def tc_04_02
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('', '12345678')
    @b.send_keys :enter
    raise 'User loggined without mail' unless
    (@b.div id: 'flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_without_mail tc_04_02
  def tc_04_03
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('', '')
    @b.send_keys :enter
    raise 'User loggined without creds' unless
    (@b.div id: 'flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_without_creds tc_04_03
  def tc_05_01
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('smaximkalavrenenko@gmail.com', '1234567890')
    @b.send_keys :enter
    raise 'User loggined with wrong mail' unless
    (@b.div id: 'flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_with_inc_mail tc_05_01
  def tc_05_02
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('admin@strongqa.com', '123456789')
    @b.send_keys :enter
    raise 'User loggined with wrong password' unless
    (@b.div id: 'flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_with_inc_passwd tc_05_02
  def tc_05_03
    @b.goto('http://demoapp.strongqa.com/users/sign_in')
    test_login('smaximkalavrenenko@gmail.com', '123456789')
    @b.send_keys :enter
    raise 'User loggined with wrong password and mail' unless
    (@b.div id: 'flash_alert').text == 'Invalid email or password.'
  end
  alias prohib_log_with_inc_creds tc_05_03
end
