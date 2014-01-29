require 'nokogiri'
require 'open-uri'
require 'json'
require 'mongo'
require 'optparse'

include Mongo

# coursecode: span class='course-code'
# coursetitle: span class='course-title'
# coursedesc: span class='course-desc'
# prereq: span class='course-prereq'
# antireq: span class='course-prereq'

def is_course_code(course_code)
  return !!(course_code =~ /^[0-9][A-Z][A-Z0-9][0-9]/i)
end

def parse_file(filename)
  f = File.open(filename)
  doc = Nokogiri::HTML(f)
  output = []

  doc.css('div.item-container').each do |coursebox|
    row = {}
    coursebox.css('span.course-code').each do |coursecode|
      if is_course_code(coursecode.content.strip)
        row[:code] = coursecode.content.strip
      end
      if coursecode['id'].index('SubjectArea') then
        row[:subject_code] = coursecode.content.strip
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

  return output
end

def parse_files_in_folder(folder_name)
  puts 'Starting parse on folder: ' + folder_name
  course_db = MongoClient.new('localhost', 27017).db('courses')

  Dir.foreach(folder_name) do |file|
    next if file == '.' or file == '..'
    file_path = folder_name + '/' + file
    course_info = parse_file(file_path)
    course_db.collection('course_list').insert(course_info)
    puts 'Parsed and wrote to DB: ' + file_path
  end
end

OptionParser.new do |opts|
  opts.banner = 'Usage: courseparser.rb [directory_path]'

  opts.on('-d', '--directory DIR', 'Directory Path') { |d| parse_files_in_folder(d) }
end.parse!

#puts parse_file('pages/18012014/18012014-0021-pg1752.html')