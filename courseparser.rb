require 'nokogiri'
require 'open-uri'

# coursecode: span class='course-code'
# coursetitle: span class='course-title'
# coursedesc: span class='course-desc'
# prereq: span class='course-prereq'
# antireq: span class='course-prereq'

def is_course_code(course_code)
  return !!(course_code =~ /^[0-9][A-Z][A-Z][0-9]/i)
end

doc = Nokogiri::HTML(open('http://registrar.mcmaster.ca/CALENDAR/current/pg2486.html'))
output = []

doc.css('div.item-container').each do |coursebox|
  row = {}
  coursebox.css('span.course-code').each do |coursecode|
    if is_course_code(coursecode.content.strip)
      row[:coursecode] = coursecode.content.strip
    end
  end
  output << row
end

puts output
# doc.css('span.course-code').each do |coursecode|
#   if is_course_code(coursecode.content.strip)
#     output << {:code => coursecode.content}
#   end
# end
# puts output.inspect

# i = 0
# doc.css('span.course-title').each do |title|
#   if !!output[i]
#     output[i].merge!({:title => title.content})
#   end
#   i = i + 1
# end

# i = 0
# doc.css('span.course-desc').each do |desc|
#   if !!output[i]
#     output[i].merge!({:desc => desc.content})
#   end
#   i = i + 1
# end

puts output