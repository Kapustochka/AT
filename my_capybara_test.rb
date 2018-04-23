module MyCapybaraTest
  # Class mixed in Capybara DSL
  class TestMethods
    include Capybara::DSL
    def test_login(login, password)
      fill_in 'Email', with: login
      fill_in 'Password', with: password
      # find(:css, '#user_password').set("#{password}\n")
    end

    def check_current_uri(url)
      curr_uri = URI.parse(current_url).to_s
      p curr_uri
      raise 'Current page is not that expected' unless curr_uri == url
    end

    def click_enter(css_selector)
      find(css_selector).native.send_keys(:return)
      ## TODO:
      sleep 5
    end

    def public_sleep(sec)
      sleep sec
    end

    def loginned?
      # click_link('Edit account')
      find_link('Edit account')
      true
    rescue StandardError
      false
    end
  end
end
