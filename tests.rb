require_relative 'boot'

describe '#login' do
  before(:all) do
    @login_page = Login.new
    @home_page = Home.new
  end

  context 'when open login page' do
    it 'should be shown login page' do
      @home_page.load
      @home_page.login_button.click
      expect(@login_page).to be_displayed
    end
  end

  context 'when creds are correct' do
    it 'should be logged in and forward to home page' do
      @login_page.load
      @login_page.email_field.set 'admin@strongqa.com'
      @login_page.password_field.set '1234567890'
      @login_page.login_button.click
      expect(@home_page).to be_displayed
      expect(@login_page).to have_content('Signed in successfully.')
    end

    after(:all) do
      @home_page.logout_button.click
    end
  end

  context 'when password is empty' do
    it 'shows the error message' do
      @login_page.load
      @login_page.email_field.set 'admin@strongqa.com'
      @login_page.password_field.set ''
      @login_page.login_button.click
      expect(@login_page).to have_content('Invalid email or password.')
    end
  end

  context 'when email is empty' do
    it 'shows the error message' do
      @login_page.load
      @login_page.email_field.set ''
      @login_page.password_field.set '1234567890'
      @login_page.login_button.click
      expect(@login_page).to have_content('Invalid email or password.')
    end
  end

  context 'when login and password are empty' do
    it 'shows the error message' do
      @login_page.load
      @login_page.email_field.set ''
      @login_page.password_field.set ''
      @login_page.login_button.click
      expect(@login_page).to have_content('Invalid email or password.')
    end
  end

  context 'when password is wrong' do
    it 'shows the error message' do
      @login_page.load
      @login_page.email_field.set 'admin@strongqa.com'
      @login_page.password_field.set 'blabla'
      @login_page.login_button.click
      expect(@login_page).to have_content('Invalid email or password.')
    end
  end

  context 'when login is wrong' do
    it 'shows the error message' do
      @login_page.load
      @login_page.email_field.set 'blablaadmin@strongqa.com'
      @login_page.password_field.set '1234567890'
      @login_page.login_button.click
      expect(@login_page).to have_content('Invalid email or password.')
    end
  end

  context 'when password and login are wrong' do
    it 'shows the error message' do
      @login_page.load
      @login_page.email_field.set 'blablaadmin@strongqa.com'
      @login_page.password_field.set 'blabla1234567890'
      @login_page.login_button.click
      expect(@login_page).to have_content('Invalid email or password.')
    end
  end
end

describe '#logout_button' do
  before(:all) do
    @login_page = Login.new
    @home_page = Home.new
  end

  context 'when logout_button is clicked' do
    it 'user should be logged off' do
      @login_page.load
      @login_page.email_field.set 'admin@strongqa.com'
      @login_page.password_field.set '1234567890'
      @login_page.login_button.click
      @home_page.logout_button.click
      expect(@home_page).to have_content('Signed out successfully.')
    end
  end
end
