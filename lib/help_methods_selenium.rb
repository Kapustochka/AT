require 'selenium-webdriver'

# class with test methods
module HelpMethods
  @@d = Selenium::WebDriver.for :firefox
  @@d.manage.timeouts.implicit_wait = 30
  @@wait = Selenium::WebDriver::Wait.new(timeout: 5)

  def open_page(url)
    puts "Open page by URL: #{url}"
    @@d.get url
  end
end
