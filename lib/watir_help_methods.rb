# TestMethods
module TestMethods
  def test_login(login, password)
    (@b.text_field id: 'user_email').set login
    (@b.text_field id: 'user_password').set password
  end
end
