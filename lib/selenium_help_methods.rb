# TestMethods
module TestMethods
  def test_login(login, password)
    (@d.find_element id: 'user_email').send_key(login)
    (@d.find_element id: 'user_password').send_key(password)
    (@d.find_element id: 'user_password').send_keys(:return)
    # (@b.text_field id: 'user_email').set login
    # (@b.text_field id: 'user_password').set password
  end

  def loginned?
    !(@d.find_elements link_text: 'Edit account').empty?
  end
end
