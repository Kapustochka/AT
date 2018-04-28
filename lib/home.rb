
require 'capybara'
require 'capybara/dsl'
require 'site_prism'
# Home page
class Home < SitePrism::Page
  set_url '/'

  element :login_button, :xpath,  '//a[text()="Login"]'
  element :logout_button, :xpath, '//a[text()="Logout"]'

  def assert_text(value)
    puts "Asserting that page contains '#{value}'"
    unless page.has_text?(value)
      raise "\tExpected text '#{page.text}' to include '#{value}'"
    end
  end
end
