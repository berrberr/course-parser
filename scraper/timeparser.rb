require 'net/http'
require 'net/https'

uri = URI.parse("https://adweb.cis.mcmaster.ca/mtt/")
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
req = Net::HTTP::Post.new(uri.path)
req['course'] = '1AA3'
res = https.request(req)
puts res.body