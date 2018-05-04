require_relative 'spec_helper'

RSpec.feature 'Sign in' do
  feature 'User' do
    given(:login_page) { Login.new }
    given(:home_page) { Home.new }

    context 'via menu' do
      scenario 'can login' do
        home_page.load
        home_page.login_button.click
        expect(login_page).to be_displayed
      end
    end
    context 'directly via login page' do
      context 'with correct creds' do
        scenario 'can login' do
          login_page.load
          login_page.email_field.set 'admin@strongqa.com'
          login_page.password_field.set '1234567890'
          login_page.login_button.click
          expect(home_page).to be_displayed
          expect(login_page).to have_content('Signed in successfully.')
          home_page.logout_button.click
        end
      end
      context 'with incorrect creds' do
        context 'with blank password' do
          scenario 'can not login' do
            login_page.load
            login_page.email_field.set 'admin@strongqa.com'
            login_page.password_field.set ''
            login_page.login_button.click
            expect(login_page).to be_displayed
            expect(login_page).to have_content('Invalid email or password.')
          end
        end
        context 'with blank email' do
          scenario 'can not login' do
            login_page.load
            login_page.email_field.set ''
            login_page.password_field.set '1234567890'
            login_page.login_button.click
            expect(login_page).to be_displayed
            expect(login_page).to have_content('Invalid email or password.')
          end
        end
        context 'with blank email and password' do
          scenario 'can not login' do
            login_page.load
            login_page.email_field.set ''
            login_page.password_field.set ''
            login_page.login_button.click
            expect(login_page).to be_displayed
            expect(login_page).to have_content('Invalid email or password.')
          end
        end
        context 'with wrong password' do
          scenario 'can not login' do
            login_page.load
            login_page.email_field.set 'admin@strongqa.com'
            login_page.password_field.set 'blabla'
            login_page.login_button.click
            expect(login_page).to be_displayed
            expect(login_page).to have_content('Invalid email or password.')
          end
        end
        context 'with wrong email' do
          scenario 'can not login' do
            login_page.load
            login_page.email_field.set 'blablaadmin@strongqa.com'
            login_page.password_field.set '1234567890'
            login_page.login_button.click
            expect(login_page).to be_displayed
            expect(login_page).to have_content('Invalid email or password.')
          end
        end
        context 'with wrong password and login' do
          scenario 'can not login' do
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
  end
end
