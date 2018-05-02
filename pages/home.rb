# Home page
class Home < SitePrism::Page
  set_url '/'

  element :login_button, :xpath,  '//a[text()="Login"]'
  element :logout_button, :xpath, '//a[text()="Logout"]'
end
