require 'selenium-webdriver'
require_relative 'selenium_help_methods'
# class with test methods
class Tests
  include TestMethods
  def initialize
    @d = Selenium::WebDriver.for :firefox
    @d.manage.timeouts.implicit_wait = 30
    @wait = Selenium::WebDriver::Wait.new(timeout: 5)
  end

  def tc_01
    @d.get 'http://demoapp.strongqa.com/'
    (@d.find_element link_text: 'Login').click
    raise 'Wrong URI' unless @d.current_url == 'http://demoapp.strongqa.com/users/sign_in'
  end
  alias open_page_via_menu tc_01

  def tc_02
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    test_login('admin@strongqa.com', '1234567890')
    raise 'Wrong URI' unless @wait.until do
      @d.current_url == 'http://demoapp.strongqa.com/'
    end
    # TODO: Ask if it neccessary to reraise custom exception ??
    @d.find_element class_name: 'alert-success'
    (@d.find_element link_text: 'Logout').click
  end
  alias login_with_correct_creds tc_02

  def tc_03_01
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    (@d.find_element id: 'user_remember_me').click
    test_login('admin@strongqa.com', '1234567890')
    # TODO: Ask if it neccessary to reraise custom exception ??

    @wait.until do
      @d.find_element class_name: 'alert-success'
    end
  end
  alias login_rememb_creds tc_03_01

  def tc_03_02
    @d.execute_script 'window.close();'
    @d.get 'http://demoapp.strongqa.com/'
    raise 'Unloggined' unless loginned?
  end
  alias login_rememb_creds_p2 tc_03_02

  def tc_03_03
    (@d.find_element link_text: 'Logout').click
    @d.execute_script 'window.close();'
    @d.get 'http://demoapp.strongqa.com/'
    raise 'Loggined' if loginned?
  end
  alias login_rememb_creds_p3 tc_03_03

  def tc_04_01
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    test_login('admin@strongqa.com', '')
    # TODO: Ask if it neccessary to reraise custom exception ??
    @wait.until do
      @d.find_element class_name: 'alert-danger'
    end
  end
  alias prohib_log_without_passwd tc_04_01

  def tc_04_02
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    test_login('', '12345678')
    # TODO: Ask if it neccessary to reraise custom exception ??
    @wait.until do
      @d.find_element class_name: 'alert-danger'
    end
  end
  alias prohib_log_without_mail tc_04_02

  def tc_04_03
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    test_login('', '')
    # TODO: Ask if it neccessary to reraise custom exception ??
    @wait.until do
      @d.find_element class_name: 'alert-danger'
    end
  end
  alias prohib_log_without_creds tc_04_03

  def tc_05_01
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    test_login('smaximkalavrenenko@gmail.com', '1234567890')
    # TODO: Ask if it neccessary to reraise custom exception ??
    @wait.until do
      @d.find_element class_name: 'alert-danger'
    end
  end
  alias prohib_log_with_inc_mail tc_05_01

  def tc_05_02
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    test_login('admin@strongqa.com', '123456789')
    # TODO: Ask if it neccessary to reraise custom exception ??
    @wait.until do
      @d.find_element class_name: 'alert-danger'
    end
  end
  alias prohib_log_with_inc_passwd tc_05_02

  def tc_05_03
    @d.get 'http://demoapp.strongqa.com/users/sign_in'
    test_login('smaximkalavrenenko@gmail.com', '123456789')
    # TODO: Ask if it neccessary to reraise custom exception ??
    @wait.until do
      @d.find_element class_name: 'alert-danger'
    end
  end
  alias prohib_log_with_inc_creds tc_05_03
end
