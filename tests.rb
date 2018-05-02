#  Tests
require_relative 'boot'

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

login_page = Login.new
home_page = Home.new
# def tests
tc('tc_01', 'open_page_via_menu') do
  home_page.load
  home_page.login_button.click
  unless login_page.displayed?
    raise "\tWrong page displayed\nExpected: '/users/sign_in'
          \nActual #{login_page.current_url}"
  end
end

tc('tc_02', 'login_with_correct_creds') do
  login_page.load
  login_page.email_field.set 'admin@strongqa.com'
  login_page.password_field.set '1234567890'
  login_page.login_button.click
  unless home_page.displayed?
    raise "\tWrong page displayed\nExpected: '/'
          \nActual#{home_page.current_url}"
  end
  unless home_page.has_text?('Signed in successfully.')
    raise "\tExpected text '#{home_page.text}'
    to include 'Signed in successfully.'"
  end
end

tc('tc_03', 'logout is working') do
  home_page.logout_button.click
  unless home_page.has_text?('Signed out successfully.')
    raise "\tExpected text '#{home_page.text}'
    to include 'Signed out successfully.'"
  end
end

tc('tc_04_1', 'prohib_log_without_passwd') do
  login_page.load
  login_page.email_field.set 'admin@strongqa.com'
  login_page.password_field.set ''
  login_page.login_button.click
  unless login_page.has_text?('Invalid email or password.')
    raise "\tExpected text '#{login_page.text}'
    to include 'Invalid email or password.'"
  end
end

tc('tc_04_2', 'prohib_log_without_mail') do
  login_page.load

  login_page.email_field.set ''
  login_page.password_field.set '12345678'
  login_page.login_button.click
  unless login_page.has_text?('Invalid email or password.')
    raise "\tExpected text '#{login_page.text}'
    to include 'Invalid email or password.'"
  end
end

tc('tc_04_3', 'prohib_log_without_creds') do
  login_page.load
  login_page.email_field.set ''
  login_page.password_field.set ''
  login_page.login_button.click
  unless login_page.has_text?('Invalid email or password.')
    raise "\tExpected text '#{login_page.text}'
    to include 'Invalid email or password.'"
  end
end

tc('tc_05_1', 'prohib_log_with_inc_mail') do
  login_page.load
  login_page.email_field.set 'smaximkalavrenenko@gmail.com'
  login_page.password_field.set '1234567890'
  login_page.login_button.click
  unless login_page.has_text?('Invalid email or password.')
    raise "\tExpected text '#{login_page.text}'
    to include 'Invalid email or password.'"
  end
end

tc('tc_05_2', 'prohib_log_with_inc_passwd') do
  login_page.load
  login_page.email_field.set 'admin@strongqa.com'
  login_page.password_field.set '123456789'
  login_page.login_button.click
  unless login_page.has_text?('Invalid email or password.')
    raise "\tExpected text '#{page.text}'
    to include 'Invalid email or password.'"
  end
end

tc('tc_05_3', 'prohib_log_with_inc_creds') do
  login_page.load
  login_page.email_field.set 'smaximkalavrenenko@gmail.com'
  login_page.password_field.set '123456789'
  login_page.login_button.click
  unless login_page.has_text?('Invalid email or password.')
    raise "\tExpected text '#{page.text}'
    to include 'Invalid email or password.'"
  end
end
# end

# tests
