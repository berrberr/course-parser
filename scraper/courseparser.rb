require 'nokogiri'
require 'open-uri'
require 'json'
require 'optparse'
require 'mysql2'

# coursecode: span class='course-code'
# coursetitle: span class='course-title'
# coursedesc: span class='course-desc'
# prereq: span class='course-prereq'
# antireq: span class='course-prereq'

def is_course_code(course_code)
  return !!(course_code =~ /^[0-9][A-Z][A-Z0-9][0-9]/i)
end

def parse_course_title(title)
  return title.sub(/\{(.*?)\}/, '').strip
end

#MySQL timestamp format
TimeFmtStr = "%Y-%m-%d %H:%M:%S"

def parse_file(filename)
  f = File.open(filename)
  doc = Nokogiri::HTML(f)
  output = {}

  if !doc.css('span.page-title')[0].nil? then output[:subject_name] = doc.css('span.page-title')[0].text end
  output[:data] = []

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
    
    if !row.empty? then
      output[:data] << row
    end

    if output[:subject_code] == nil and row[:subject_code] != nil then
      output[:subject_code] = row[:subject_code]
    end

  end

  return output
end

def parse_files_in_folder(folder_name)
  puts 'Starting parse on folder: ' + folder_name
  client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'coursesite')
  subjects_added = []

  Dir.foreach(folder_name) do |file|
    next if file == '.' or file == '..'
    file_path = folder_name + '/' + file
    course_info = parse_file(file_path)
    data_hash = course_info[:data]
    data_hash.each do |dh|
      timestamp = Time.now.strftime(TimeFmtStr)
      dh.each { |k, v| dh[k] = client.escape(v.to_s) }
      q = "INSERT INTO courses(course_code, subject_code, title, description, prereq, antireq, crosslist, created_at, updated_at)
            VALUES('#{dh[:code]}', '#{dh[:subject_code]}', '#{dh[:title]}', '#{dh[:description]}', '#{dh[:prereq]}', '#{dh[:antireq]}', '#{dh[:crosslist]}', '#{timestamp}', '#{timestamp}')"
      result = client.query(q)
    end

    if !subjects_added.include? course_info[:subject_code] then
      timestamp = Time.now.strftime(TimeFmtStr)
      title = (course_info[:subject_name].nil?)? '' : parse_course_title(client.escape(course_info[:subject_name]))
      code = (course_info[:subject_code].nil?)? '' : client.escape(course_info[:subject_code])
      q = "INSERT INTO subjects(subject_code, name, created_at, updated_at) 
            VALUES('#{code}', '#{title}', '#{timestamp}', '#{timestamp}')"
      if code.present? then
        client.query(q)
        subjects_added << course_info[:subject_code]
      end
    end
            
    puts 'Parsed and wrote to DB: ' + file_path
  end
end

OptionParser.new do |opts|
  opts.banner = 'Usage: courseparser.rb [directory_path]'

  opts.on('-d', '--directory DIR', 'Directory Path') { |d| parse_files_in_folder(d) }
  opts.on('-p', '--parse FILE', 'File path') { |p| 
    output = parse_file(p) 
    puts output.inspect
  }
end.parse!

#puts parse_file('pages/18012014/18012014-0021-pg1752.html')