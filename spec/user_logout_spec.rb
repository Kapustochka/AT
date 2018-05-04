require_relative  'spec_helper'

RSpec.describe 'Logging out' do
  describe 'User' do
    let(:login_page) { Login.new }
    let(:home_page) { Home.new }

    it 'can log off' do
      login_page.load
      login_page.email_field.set 'admin@strongqa.com'
      login_page.password_field.set '1234567890'
      login_page.login_button.click
      home_page.logout_button.click
      expect(home_page).to have_content('Signed out successfully.')
    end
  end
end
