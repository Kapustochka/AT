require 'spec_helper'

module UserLoginSteps
  # Given

  def login_page
    @login_page ||= Login.new
  end

  def home_page
    @home_page ||= Home.new
  end

  step 'user is on login page' do
    login_page.load
  end

  step 'user is on home page' do
    home_page.load
  end

  # When

  step 'user clicks login button on home page' do
    home_page.login_button.click
  end

  step 'user clicks logout button' do
    home_page.logout_button.click
  end

  step 'user logs in with correct creds' do
    login_page.email_field.set 'admin@strongqa.com'
    login_page.password_field.set '1234567890'
    login_page.login_button.click
  end

  step 'user logs in with incorrect password' do
    login_page.email_field.set 'admin@strongqa.com'
    login_page.password_field.set 'bla1234567890'
    login_page.login_button.click
  end

  step 'user logs in with incorrect email' do
    login_page.email_field.set 'blaadmin@strongqa.com'
    login_page.password_field.set '1234567890'
    login_page.login_button.click
  end

  step 'user logs in with incorrect email and password' do
    login_page.email_field.set 'blaadmin@strongqa.com'
    login_page.password_field.set 'bla1234567890'
    login_page.login_button.click
  end

  step 'user logs in with blank password' do
    login_page.email_field.set 'admin@strongqa.com'
    login_page.password_field.set ''
    login_page.login_button.click
  end

  step 'user logs in with blank email' do
    login_page.email_field.set ''
    login_page.password_field.set '1234567890'
    login_page.login_button.click
  end

  step 'user logs in with blank email and password' do
    login_page.email_field.set ''
    login_page.password_field.set ''
    login_page.login_button.click
  end

  step 'home page should be displayed' do
    expect(home_page).to be_displayed
  end

  step 'login page should be displayed' do
    expect(login_page).to be_displayed
  end

  step 'home page should have content :content' do |content|
    expect(home_page).to have_content(content)
  end

  step 'login page should have content :content' do |content|
    expect(login_page).to have_content(content)
  end

  step 'user should see alert about successfull sign in' do
    expect(home_page).to have_content('Signed in successfully.')
  end

  step 'user should see alert about successfull sign out' do
    expect(home_page).to have_content('Signed out successfully.')
  end

  step 'user should see alert about wrong login or password' do
    expect(login_page).to have_content('Invalid email or password.')
  end
end

RSpec.configure { |c| c.include UserLoginSteps }
