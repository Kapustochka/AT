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
    @home_page.login_button.click
    if @login_page.displayed?
      @login_page.login_button.click
    elsif @home_page.displayed?
      @home_page.login_button.click
    end
  end
# Then
  step ':page page is displayed' do |page|
    @home_page.login_button.click
    if page =~ /login/i
      expect(@login_page).to be_displayed
    elsif page =~ /home/i
      expect(@home_page).to be_displayed
    end
  end
end
RSpec.configure { |c| c.include UserLoginSteps }
