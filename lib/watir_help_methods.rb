# TestMethods
module TestMethods
  def test_login(login, password)
    (@b.text_field id: 'user_email').set login
    (@b.text_field id: 'user_password').set password
  end

  def loginned?
    (@b.link text: 'Edit account').exists?
  end

  def close_coockie_save
    my_cookies = @b.cookies.to_a
    @b.quit
    browser = Watir::Browser.new :firefox
    my_cookies.each do |cookie|
      browser.cookies.add(cookie[:name], cookie[:value])
    end
    browser
  end
end
