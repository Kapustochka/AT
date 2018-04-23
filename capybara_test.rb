require 'capybara'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'

Capybara.javascript_driver = :chrome

module MyCapybaraTest
  class TestMethods
    include Capybara::DSL
    def test_login(login, password)
      fill_in 'Email', with: login
      fill_in 'Password', with: password
      # find(:css, '#user_password').set("#{password}\n")
    end

    def check_current_uri(url)
      curr_uri = URI.parse(current_url).to_s
      p curr_uri
      raise 'Current page is not that expected' unless curr_uri == url
    end

    def click_enter(css_selector)
      find(css_selector).native.send_keys(:return)
      ## TODO:
      sleep 5
    end

    def public_sleep(sec)
      sleep sec
    end

    def loginned?
      # click_link('Edit account')
      find_link('Edit account')
      true
    rescue StandardError
      false
    end
  end
end
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

  def tc_02
    @t.visit('/users/sign_in')
    @t.test_login('maximkalavrenenko@gmail.com', '12345678')
    @t.click_enter('#user_password')
    @t.check_current_uri('http://demoapp.strongqa.com/')
    raise '"Signed successfully" record wasn\'t found' unless
    @t.find('#flash_notice').text == 'Signed in successfully.'
  end

  def tc_03_01
    @t.visit('/users/sign_in')
    @t.test_login('maximkalavrenenko@gmail.com', '12345678')
    @t.check('Remember me')
    @t.click_enter('#user_password')
    raise '"Signed successfully" record wasn\'t found' unless
    @t.find('#flash_notice').text == 'Signed in successfully.'
  end

  def tc_03_02
    tc_03_01
    @t.page.execute_script 'window.close();'
    @t.visit('/')
    raise 'Unloggined' unless @t.loginned?
  end

  def tc_03_03
    tc_03_02
    @t.click_link('Logout')
    @t.page.execute_script 'window.close();'
    @t.visit('/')
    raise 'Loggined' if @t.loginned?
    @t.public_sleep 5
  end
  # t.test_login
end
test = Tests.new

test.tc_03_03
