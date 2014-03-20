require 'mechanize'

# create Mechanize instance
a = Mechanize.new
a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# get the login form & fill it out with the username/password
ttform = a.get("https://adweb.cis.mcmaster.ca/mtt/").form('MTTSearch')
ttform.course = '1AA3'
ttform.subject = '010'

# submit login form
resp = a.submit(ttform, ttform.buttons.first)
puts resp.body