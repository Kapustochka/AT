require_relative 'spec_helper'

RSpec.feature 'Logging out' do
  feature 'User' do
    given(:login_page) { Login.new }
    given(:home_page) { Home.new }

    scenario 'can log off' do
      login_page.load
      login_page.email_field.set 'admin@strongqa.com'
      login_page.password_field.set '1234567890'
      login_page.login_button.click
      home_page.logout_button.click
      expect(home_page).to have_content('Signed out successfully.')
    end
  end
end
