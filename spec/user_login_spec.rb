require 'spec_helper'

RSpec.describe 'Sign in' do
  describe 'User' do
    let(:login_page) { Login.new }
    let(:home_page) { Home.new }

    context 'can login' do
      it 'via menu' do
        home_page.load
        home_page.login_button.click
        expect(login_page).to be_displayed
      end

      it 'with correct creds' do
        login_page.load
        login_page.email_field.set 'admin@strongqa.com'
        login_page.password_field.set '1234567890'
        login_page.login_button.click
        expect(home_page).to be_displayed
        expect(login_page).to have_content('Signed in successfully.')
        home_page.logout_button.click
      end
    end

    context 'can not login' do
      it 'with blank password' do
        login_page.load
        login_page.email_field.set 'admin@strongqa.com'
        login_page.password_field.set ''
        login_page.login_button.click
        expect(login_page).to be_displayed
        expect(login_page).to have_content('Invalid email or password.')
      end

      it 'with blank email' do
        login_page.load
        login_page.email_field.set ''
        login_page.password_field.set '1234567890'
        login_page.login_button.click
        expect(login_page).to be_displayed
        expect(login_page).to have_content('Invalid email or password.')
      end

      it 'with blank email and password' do
        login_page.load
        login_page.email_field.set ''
        login_page.password_field.set ''
        login_page.login_button.click
        expect(login_page).to be_displayed
        expect(login_page).to have_content('Invalid email or password.')
      end

      it 'with wrong password' do
        login_page.load
        login_page.email_field.set 'admin@strongqa.com'
        login_page.password_field.set 'blabla'
        login_page.login_button.click
        expect(login_page).to be_displayed
        expect(login_page).to have_content('Invalid email or password.')
      end

      it 'with wrong email' do
        login_page.load
        login_page.email_field.set 'blablaadmin@strongqa.com'
        login_page.password_field.set '1234567890'
        login_page.login_button.click
        expect(login_page).to be_displayed
        expect(login_page).to have_content('Invalid email or password.')
      end

      it 'with wrong password and login' do
        login_page.load
        login_page.email_field.set 'blablaadmin@strongqa.com'
        login_page.password_field.set 'blabla1234567890'
        login_page.login_button.click
        expect(login_page).to be_displayed
        expect(login_page).to have_content('Invalid email or password.')
      end
    end
  end
end
