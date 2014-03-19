require 'mechanize'

# create Mechanize instance
a = Mechanize.new

cert_store = OpenSSL::X509::Store.new
cert_store.add_file 'cacert.pem'
a.cert_store = cert_store

a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# get the login form & fill it out with the username/password
ttform = a.get("https://adweb.cis.mcmaster.ca/mtt/").form('MTTSearch')
ttform.course = '1AA3'
ttform.subject = '010'

# submit login form
resp = a.submit(ttform, ttform.buttons.first)
puts resp.body