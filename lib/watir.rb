require 'rubygems'
require 'watir'
require_relative 'watir_help_methods'
# require "watir/extensions/wait"

# browser = Watir::Browser.new :firefox
# browser.goto 'http://google.com'
# browser.text_field(:name, 'q').set 'watir-webdriver'
# browser.button(:name, 'btnG').click

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
    ## TODO:
    sleep 2
    p @b.url
    raise 'Wrong URI' unless @b.url == 'http://demoapp.strongqa.com/'
    raise '"Signed successfully" record wasn\'t found' unless
    (@b.div id: 'flash_notice').text == 'Signed in successfully.'
    @b.close
  end
end

test = Tests.new
test.tc_02
