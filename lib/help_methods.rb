# HelpMethods
module HelpMethods
  include Capybara::DSL
  # Actions
  def open_page(url)
    puts "Open page by URL: #{url}"
    visit url
  end

  def click_link_custom(link_name)
    puts "Click link with URL: #{link_name}"
    click_link(link_name)
  end

  def check_current_uri(uri)
    puts "Checking if current uri equals #{uri}"
    sleep 2
    curr_uri = URI.parse(current_url).to_s
    raise 'Current page is not that expected' unless curr_uri == uri
  end

  def test_login(login, password)
    puts "Logging in with login=#{login} and password = #{password}"
    fill_in 'Email', with: login
    fill_in 'Password', with: password
    find('#user_password').native.send_keys(:return)
  end

  def page_text
    page.text
  end

  # Checks

  def assert_page_text(name, value)
    puts "Asserting that page contains #{value}"
    unless page_text.include?(value)
      puts "#{name}: FAILED"
      raise "\tExpected text '#{page_text}' to include '#{value}'"
    end
  end
end
