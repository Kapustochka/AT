require 'capybara'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'
include Capybara::DSL
# Actions
def open_page(url)
  puts "Open page by URL: #{url}"
  visit url
end

def click_link_custom(link_name)
  puts "Click link with URL: #{link_name}"
  click_link(link_name)
end

def test_login(login, password)
  puts "Logging in with login=#{login} and password = #{password}"
  fill_in 'Email', with: login
  fill_in 'Password', with: password
  find('#user_password').native.send_keys(:return)
end

def page_text
  page.text
end

# Checks

def assert_page_text(value)
  puts "Asserting that page contains '#{value}'"
  unless page.has_text?(value)
    puts "#{name}: FAILED"
    raise "\tExpected text '#{page_text}' to include '#{value}'"
  end
end

def check_current_uri(uri)
  puts "Checking if current uri equals #{uri}"
  page.assert_current_path(uri)
end
# end
