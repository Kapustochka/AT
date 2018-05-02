# Login Page
class Login < SitePrism::Page
  set_url '/users/sign_in'

  element :email_field, 'input#user_email'
  element :password_field, 'input#user_password'
  element :login_button, 'input.button'

end
