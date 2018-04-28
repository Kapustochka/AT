# Login page
require 'capybara'
require 'capybara/dsl'
require 'site_prism'

class Login < SitePrism::Page
  set_url '/users/sign_in'

  element :email_field, 'input#user_email'
  element :password_field, 'input#user_password'
  element :login_button, 'input.button'

  def login(login, password)
    email_field.set login
    password_field.set password
    login_button.click
  end

  def assert_text(value)
    puts "Asserting that page contains '#{value}'"
    unless page.has_text?(value)
      raise "\tExpected text '#{page.text}' to include '#{value}'"
    end
  end
end
