require_relative 'lib/selenium'

test = Tests.new
test.open_page_via_menu
test.login_with_correct_creds
test.login_rememb_creds # Is prereq. for login_rememb_creds_p2
test.login_rememb_creds_p2 # Is prereq. for login_rememb_creds_p3
test.login_rememb_creds_p3
test.prohib_log_without_passwd
test.prohib_log_without_mail
test.prohib_log_without_creds
test.prohib_log_with_inc_mail
test.prohib_log_with_inc_passwd
test.prohib_log_with_inc_creds
puts 'tests are successfull'
