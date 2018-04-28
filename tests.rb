#  Tests

require_relative 'boot'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://demoapp.strongqa.com'

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

@login_page = Login.new
@home_page = Home.new
def tests
  tc('tc_01', 'open_page_via_menu') do
    @home_page.load
    @home_page.login_button.click
    @login_page.displayed_custom
  end

  tc('tc_02', 'login_with_correct_creds') do
    # open_page '/users/sign_in'
    @login_page.load
    @login_page.login('admin@strongqa.com', '1234567890')
    @home_page.displayed_custom
    @home_page.assert_text('Signed in successfully.')
  end

  tc('tc_03', 'logout is working') do
    @home_page.logout_button.click
    @home_page.assert_text('Signed out successfully.')
  end

  tc('tc_04_1', 'prohib_log_without_passwd') do
    @login_page.load
    @login_page.login('admin@strongqa.com', '')
    @login_page.assert_text('Invalid email or password.')
  end

  tc('tc_04_2', 'prohib_log_without_mail') do
    @login_page.load
    @login_page.login('', '12345678')
    @login_page.assert_text('Invalid email or password.')
  end

  tc('tc_04_3', 'prohib_log_without_creds') do
    @login_page.load
    @login_page.login('', '')
    @login_page.assert_text('Invalid email or password.')
  end

  tc('tc_05_1', 'prohib_log_with_inc_mail') do
    @login_page.load
    @login_page.login('smaximkalavrenenko@gmail.com', '1234567890')
    @login_page.assert_text('Invalid email or password.')
  end

  tc('tc_05_2', 'prohib_log_with_inc_passwd') do
    @login_page.load
    @login_page.login('admin@strongqa.com', '123456789')
    @login_page.assert_text('Invalid email or password.')
  end

  tc('tc_05_3', 'prohib_log_with_inc_creds') do
    @login_page.load
    @login_page.login('smaximkalavrenenko@gmail.com', '123456789')
    @login_page.assert_text('Invalid email or password.')
  end
end

tests
