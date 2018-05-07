require 'spec_helper'

module UserLoginSteps
  # Given
  attr_accessor :login_page, :home_page
  attr_accessor :correct_pass, :correct_email, :incorrect_pass, :incorrect_email

  correct_pass = '1234567890'
  correct_email = 'admin@strongqa.com'
  incorrect_pass = 'bla1234567890'
  incorrect_email = 'blaadmin@strongqa.com'

  step 'there is a :page page' do |page|
    if page.match?(/login/i)
      self.login_page = Login.new
    elsif page.match?(/home/i)
      self.home_page = Home.new
    end
  end

  step 'user is on :page page' do |page|
    if page.match?(/login/i)
      login_page.load
    elsif page.match?(/home/i)
      login_page.load
    end
  end
  # When
  step 'user clicks login button' do
    if login_page.displayed?
      login_page.login_button.click
    elsif home_page.displayed?
      home_page.login_button.click
    end
  end

  step 'user clicks logout button' do
    home_page.logout_button.click
  end

  step 'user fills in email field with :email' do |email|
    login_page.email_field.set email
  end

  step 'user fills in password field with :password' do |password|
    login_page.password_field.set password
  end

  step 'user logs in with correct creds' do
    send 'user fills in email field with :email', correct_email #'admin@strongqa.com'
    send 'user fills in password field with :password', correct_pass #'1234567890'
    send 'user clicks login button'
  end

  step 'user logs in with incorrect :cred' do |cred|
    if cred.match?(/passw/i)
      send 'user fills in email field with :email',correct_email #'admin@strongqa.com'
      send 'user fills in password field with :password', incorrect_pass #'blabla'
      send 'user clicks login button'
    elsif cred.match?(/email/i)
      send 'user fills in email field with :email', incorrect_email #'blablaadmin@strongqa.com'
      send 'user fills in password field with :password', correct_pass #'1234567890'
      send 'user clicks login button'
    elsif cred.match?(/both/i)
      send 'user fills in email field with :email', incorrect_email #'2blablaadmin@strongqa.com'
      send 'user fills in password field with :password', incorrect_pass #'blabla1234567890'
      send 'user clicks login button'
    end
  end

  step 'user logs in with blank :cred' do |cred|
    if cred.match?(/passw/i)
      send 'user fills in email field with :email', correct_email #'admin@strongqa.com'
      send 'user fills in password field with :password', ''
      send 'user clicks login button'
    elsif cred.match?(/email/i)
      send 'user fills in email field with :email', ''
      send 'user fills in password field with :password', correct_pass  #'1234567890'
      send 'user clicks login button'
    elsif cred.match?(/both/i)
      send 'user fills in email field with :email', ''
      send 'user fills in password field with :password', ''
      send 'user clicks login button'
    end
  end


  # Then
  step ':page page should be displayed' do |page|
    if page.match?(/login/i)
      expect(login_page).to be_displayed
    elsif page.match?(/home/i)
      expect(home_page).to be_displayed
    end
  end

  step ':page page should have content :content' do |page, content|
    if page.match?(/login/i)
      expect(login_page).to have_content(content)
    elsif page.match?(/home/i)
      expect(login_page).to have_content(content)
    end
  end
end
placeholder :cred do
  match(/(passw.*email.*)|(email.*passw.*)/) do
    'both'
  end
  match(/password/) do
    'password'
  end
  match(/email/) do
    'email'
  end
end
RSpec.configure { |c| c.include UserLoginSteps }
