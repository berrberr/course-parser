require 'uri'
require 'net/https'

url = URI.parse('https://adweb.cis.mcmaster.ca/mtt/')
http = Net::HTTP.new(url.host, url.port)
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
http.use_ssl = true

request = Net::HTTP::Post.new(url.request_uri)
request.set_form_data({"course" => "1AA3"})

response = http.request(request)
puts response.body
# http.start do |agent|
#   p agent.get(url.path).read_body.length
# end