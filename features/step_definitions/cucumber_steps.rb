
def login_page
  @login_page ||= Login.new
end

def home_page
  @home_page ||= Home.new
end

Given('user is on home page') do
  home_page.load
end

When('user clicks login button on home page') do
  home_page.login_button.click
end

Then('login page should be displayed') do
  expect(login_page).to be_displayed
end

Given('user is on login page') do
  login_page.load
end

When('user logs in with correct creds') do
  login_page.email_field.set 'admin@strongqa.com'
  login_page.password_field.set '1234567890'
  login_page.login_button.click
end

Then('home page should be displayed') do
  expect(home_page).to be_displayed
end

Then('user should see alert about successfull sign in') do
  expect(home_page).to have_content('Signed in successfully.')
end

When('user logs in with blank password') do
  login_page.email_field.set 'admin@strongqa.com'
  login_page.password_field.set ''
  login_page.login_button.click
end

Then('user should see alert about wrong login or password') do
  expect(login_page).to have_content('Invalid email or password.')
end

When('user logs in with blank email and password') do
  login_page.email_field.set ''
  login_page.password_field.set ''
  login_page.login_button.click
end

When('user logs in with incorrect email') do
  login_page.email_field.set 'blaadmin@strongqa.com'
  login_page.password_field.set '1234567890'
  login_page.login_button.click
end

When('user logs in with incorrect password') do
  login_page.email_field.set 'admin@strongqa.com'
  login_page.password_field.set 'bla1234567890'
  login_page.login_button.click
end

When('user logs in with incorrect email and password') do
  login_page.email_field.set 'blaadmin@strongqa.com'
  login_page.password_field.set 'bla1234567890'
  login_page.login_button.click
end

When('user clicks logout button') do
  home_page.logout_button.click
end

Then('user should see alert about successfull sign out') do
  expect(home_page).to have_content('Signed out successfully.')
end
