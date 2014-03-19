require 'uri'
require 'net/https'
require 'mechanize'

url = URI.parse('https://adweb.cis.mcmaster.ca/mtt/spmastres.php')
http = Net::HTTP.new(url.host, url.port)
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
http.use_ssl = true

subject_course_codes = {
  '010' => ['1AA3']
}

subject_course_codes.each do |subject_code, courses|
  courses.each do |course_code|
    request = Net::HTTP::Post.new(url.request_uri, {
      'Referer' => 'https://adweb.cis.mcmaster.ca/mtt/',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Origin' => 'https://adweb.cis.mcmaster.ca',
      'User-Agent'=> "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)",
      'Host' => 'adweb.cis.mcmaster.ca'
    })
    request.set_form([['course', course_code], ['subject', subject_code], ['session', 'U201405']])
    

    response = http.request(request)
    File.write(subject_code + '-' +  course_code + '.html', response.body)
    puts 'wrote: ' + subject_code + '-' +  course_code + '.html'
  end
end

# http.start do |agent|
#   p agent.get(url.path).read_body.length
# end