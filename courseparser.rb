require 'nokogiri'
require 'open-uri'

# coursecode: span class='course-code'
# coursetitle: span class='course-title'
# coursedesc: span class='course-desc'
# prereq: span class='course-prereq'
# antireq: span class='course-prereq'

def is_course_code(course_code)
  return !!(course_code =~ /^[0-9][A-Z][A-Z0-9][0-9]/i)
end

doc = Nokogiri::HTML(open('http://registrar.mcmaster.ca/CALENDAR/current/pg2486.html'))
output = []

doc.css('div.item-container').each do |coursebox|
  row = {}
  coursebox.css('span.course-code').each do |coursecode|
    if is_course_code(coursecode.content.strip)
      row[:code] = coursecode.content.strip
    end
  end
  if coursebox.css('span.course-title')[0] then 
    row[:title] = coursebox.css('span.course-title')[0].content.strip 
  end
  if coursebox.css('span.course-desc')[0] then 
    row[:description] = coursebox.css('span.course-desc')[0].content.strip 
  end

  if coursebox.css('td.myCell')[0] then
    coursebox.css('span.course-label').each do |inner|
      if inner.content.strip.index('Prereq') then
        row[:prereq] = inner.next_element.content
      end
      if inner.content.strip.index('Antireq') then
        row[:antireq] = inner.next_element.content
      end
      if inner.content.strip.index('Cross-List') then
        row[:crosslist] = inner.next_element.content
      end
    end
  end
  
  if !!row then
    output << row
  end
end

puts output

