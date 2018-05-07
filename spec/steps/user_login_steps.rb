require 'spec_helper'

module UserLoginSteps
  # Given
  step 'there is a :page page' do |page|
    if page =~ /login/i
      @login_page = Login.new
    elsif page =~ /home/i
      @home_page = Home.new
    end
  end

  step 'I am on :page page' do |page|
    if page =~ /login/i
      @login_page.load
    elsif page =~ /home/i
      @home_page.load
    end
  end
  # When
  step 'I click login button' do
    if @login_page.displayed?
      @login_page.login_button.click
    elsif @home_page.displayed?
      @home_page.login_button.click
    end
  end

  step 'I click logout button' do
    @home_page.logout_button.click
  end

  step 'I fill in email field with :email' do |email|
    @login_page.email_field.set email
  end

  step 'I fill in password field with :password' do |password|
    @login_page.password_field.set password
  end

  # Then
  step ':page page is displayed' do |page|
    if page =~ /login/i
      expect(@login_page).to be_displayed
    elsif page =~ /home/i
      expect(@home_page).to be_displayed
    end
  end

  step ':page page has content :content' do |page, content|
    if page =~ /login/i
      expect(@login_page).to have_content(content)
    elsif page =~ /home/i
      expect(@home_page).to have_content(content)
    end
  end
end
RSpec.configure { |c| c.include UserLoginSteps }
