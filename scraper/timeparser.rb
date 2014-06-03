require 'mechanize'
require 'nokogiri'
require 'fileutils'
require 'mysql2'
require 'slop'
require 'ostruct'
require_relative 'modules/coursedatabase'

#URL for timetable page
MTTURL = "https://adweb.cis.mcmaster.ca/mtt/"

@client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'coursesite')

#MySQL timestamp format
TimeFmtStr = "%Y-%m-%d %H:%M:%S"

# Download timetable pages
# @param start_from [str] subject code to start from (default nil)
def get_timetable_pages(start_from = nil)
  puts "SF: #{start_from.inspect} Nil? #{start_from.nil?}"
  #create Mechanize instance
  a = Mechanize.new
  a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #so it wont time out
  a.follow_meta_refresh = true
  a.keep_alive = false

  #get the subject codes from the tt page
  ttPage = a.get(MTTURL)

  subjects = {}
  doc = Nokogiri::HTML(ttPage.body)
  start_reached = start_from.nil? or start_from == -1

  #iterate over the subject combo box and create a hash of form subject_name => subject MTT code
  doc.css('select[name=subject]').css('option').each do |subject|
    if(!start_reached) then start_reached = subject['value'] == start_from end
    if(start_reached) then subjects[subject.text.split('-')[0]] = subject['value'] end
    #if(subject['value'] != 'all') then subjects[subject.text.split('-')[0]] = subject['value'] end
  end

  if(!subjects.empty?) then
    #each subject code
    subjects.each do |subject_name, subject_code|
      begin
        #get the list of courses by subject name (which is the code) from the database
        #NOTE: must have run coursetimes.rb first to generate this list
        courses_query = "SELECT * FROM courses WHERE subject_code='" + subject_name + "'"
        courses = @client.query(courses_query)
        courses.map do |course|
          #get the TT main page, get the form from it, submit contents
          ttPage = a.get(MTTURL)
          ttForm = ttPage.form('MTTSearch')
          ttForm.course = course['course_code']
          ttForm.subject = subject_code
          #NOTE: change this to the course session value we are parsing
          #TODO: make this a param
          ttForm.session = 'U201405'
          resp = a.submit(ttForm, ttForm.buttons.first)

          begin
            #check if there is a link to the course page
            courseLink = resp.link_with(:text => course['course_code'])
          rescue
            puts "ERROR: link_with error, page is: #{resp.inspect}"
            courseLink = nil
          end
          if(!courseLink.nil?) then
            # courseHref = MTTURL + courseLinks[0]['href']
            # puts "#{subject_code}-#{course['course_code']} href: #{courseHref.inspect}"
            # coursePage = a.get(courseHref)
            coursePage = courseLink.click

            #write the contents of the course page to a file for parsing later
            fPath = 'data/courses/' + subject_code + '/' + course['course_code'] + '.html'
            dirname = File.dirname(fPath)
            unless File.directory?(dirname)
             FileUtils.mkdir_p(dirname)
            end

            File.write(fPath, coursePage.body)
            timestamp = Time.now.strftime(TimeFmtStr)
            CourseDatabase.update_query(OpenStruct.new(
              :table => 'courses',
              :timestamp => ['parsed_at'],
              :condition => [
                {:column => 'course_code', :val => course['course_code']}, 
                {:column => 'subject_code', :val => subject_name}
              ]
            ))
            puts 'Wrote: ' + fPath
          else
            puts "Skipped: #{subject_code} - #{course['course_code']}"
          end
          #wait for next exec
          sleep Random.new.rand(1..10) 
        end
      rescue => msg
        puts "Something bad happened! #{msg}"
      end
    end
  end
end

# Get and insert professor info into DB
def get_professor_list()
  #create Mechanize instance
  a = Mechanize.new
  a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  ttPage = a.get(MTTURL)
  professors = []
  doc = Nokogiri::HTML(ttPage.body)
  doc.css('select[name=instructor]').css('option').each do |professor|
    if(professor['value'] != 'all') then professors << professor['value'] end
  end

  if(!professors.empty?) then
    professors.each do |full_name|
      first_name = @client.escape(full_name.split(',')[1].strip)
      last_name = @client.escape(full_name.split(',')[0].strip)
      professor_query = "SELECT * FROM professors WHERE first_name='#{first_name}' AND last_name='#{last_name}'"
      #new professor
      if(@client.query(professor_query).count == 0) then
        timestamp = Time.now.strftime(TimeFmtStr)
        professor_insert_query = "INSERT INTO professors(first_name, last_name, created_at, updated_at)
                                  VALUES('#{first_name}', '#{last_name}', '#{timestamp}', '#{timestamp}')"
        @client.query(professor_insert_query)
        puts "INSERTED: #{first_name} #{last_name}"
      end
    end
  end

  subjects = {}
  doc.css('select[name=subject]').css('option').each do |subject|
    if(subject['value'] != 'all') then subjects[subject.text.split('-')[0]] = subject['value'] end
  end

  if(!subjects.empty?) then
    subjects.each do |subject_code, mtt_code|
      subject_code_query = "SELECT id FROM subjects WHERE subject_code='#{subject_code}'"
      if(@client.query(subject_code_query).count != 0) then
        timestamp = Time.now.strftime(TimeFmtStr)
        mtt_code_query = "UPDATE subjects SET mtt_code='#{mtt_code}', updated_at='#{timestamp}' WHERE subject_code='#{subject_code}'"
        @client.query(mtt_code_query)
        puts "Inserted MTT: #{mtt_code_query}"
      end
    end
  end
end

def check_course_exists(course_code, subject_code)
  check_query = "SELECT id FROM courses WHERE subject_code='" + subject_code + "' AND course_code='" + course_code + "'"
  return (@client.query(check_query).count != 0)
end

class CourseTime
  def initialize(params = {})
    @tr = params.fetch(:tr)
    @course_code = params.fetch(:course_code)
    @subject_code = params.fetch(:subject_code)
    @daytime = params.fetch(:daytime, nil)
    @session = params.fetch(:session, nil)
    @client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :database => 'coursesite')
  end

  def clean_data(data)
    if(data) then
      return data.gsub(/[^0-9a-z \-\/:;]/i, "")
    else
      return ''
    end
  end

  def get_day_times()
    days = @tr.css('td:nth-child(3)').text
    times = @tr.css('td:nth-child(4)').text + '*' + @tr.css('td:nth-child(5)').text
    if(!days.empty? and !times.empty?) then
      days_arr = days.split(' ').map { |d| d.strip.upcase }
      days_arr.map! { |d| d + times + ';' }
      return days_arr.join('')
    else
      return false
    end
  end

  def get_term()
    return clean_data(@tr.css('td:nth-child(6)').text)
  end

  def get_prof()
    prof_name = clean_data(@tr.css('td:nth-child(8)').text).strip

    if(!prof_name.empty?) then
      if(prof_name.split(' ').size > 1) then
        #TODO: split by regex on space here (>1 space)
        first_name = @client.escape(prof_name.split(' ')[1].strip)
        last_name = @client.escape(prof_name.split(' ')[0].strip)
        professor_query = "SELECT * FROM professors WHERE first_name='#{first_name}' AND last_name='#{last_name}'"
        if(@client.query(professor_query).count != 0) then
          return @client.query(professor_query).first['id']
        end
      end
    end
    #make -1 the not found id
    return -1
  end

  def get_core()
    return clean_data(@tr.css('td:nth-child(2)').text)
  end
  def get_term()
    return clean_data(@tr.css('td:nth-child(6)').text)
  end
  def get_location()
    return clean_data(@tr.css('td:nth-child(7)').text)
  end
  def get_notes()
    return clean_data(@tr.css('td:nth-child(9)').text)
  end

  #TODO: check if time already exists?
  def parse_data()
    time_check_query = "SELECT id FROM times WHERE course_code='#{@course_code}' AND subject_code='#{@subject_code}' AND times='#{get_day_times}'"
    if(@client.query(time_check_query).count == 0) then
      if(get_day_times()) then
        timestamp = Time.now.strftime(TimeFmtStr)
        time_query = "INSERT INTO times(course_code, subject_code, times, professor_id, room, core, notes, term, session, daytime, created_at, updated_at)
        VALUES('#{@course_code}', '#{@subject_code}', '#{get_day_times()}', #{get_prof()}, '#{get_location()}', '#{get_core()}',
              '#{get_notes()}', #{get_term()}, '#{@session}', '#{@daytime}', '#{timestamp}', '#{timestamp}')"
        puts "Inserted query: #{time_query}"
        @client.query(time_query)
      else
        puts "ERROR: Parsing times failed for #{@subject_code} - #{@course_code}"
      end
    else
      puts "ERROR: Duplicate: #{time_check_query}"
    end
  end

end

def parse_file(filename)
  puts 'Parsing: ' + filename
  f = File.open(filename)
  doc = Nokogiri::HTML(f)
  output = {}
  i = 1

  course_header = doc.xpath('//table//tr[contains(., "Course Offering")]')
  subject_code = course_header.css('td:nth-child(2)').text.gsub(/[^0-9a-z ]/i, "")
  course_code = course_header.css('td:nth-child(3)').text.gsub(/[^0-9a-z ]/i, "")
  daytime = course_header.css('td:nth-child(5)').text.gsub(/[^0-9a-z ]/i, "")

  session_header = doc.xpath('//table//tr[contains(., "Session")]')
  session = session_header.css('td:nth-child(2)').text

  if(check_course_exists(course_code, subject_code)) then
    doc.xpath('//table[.//th[contains(., "Status")]]//tr').each do |tr|
      #the course timetable rows start at the 4th tr
      if(i >= 4) then
        #TODO: pass in daytime
        course_time = CourseTime.new({
          :tr => tr,
          :course_code => course_code,
          :subject_code => subject_code,
          :session => session,
          :daytime => daytime
        })
        course_time.parse_data()
      end
      i = i + 1
    end
  end
end

def parse_files_in_folder(folder_name)
  puts 'Starting parse on folder: ' + folder_name

  Dir.glob(folder_name + '/**/*').each do |f|
    if(File.file?(f))
      parse_file(f)
    end
  end

end

opts = Slop.parse do
  on :d, :directory=, 'Directory Path'
  on :a, 'get_all', 'Get All Pages'
  on :g, :start=, :default => -1
  on :p, 'professors', 'Get Professor List'
end

unless opts[:d].nil? then parse_files_in_folder(opts[:d]) end
unless opts[:g].nil? then get_timetable_pages(opts[:g]) end
unless opts[:a].nil? then get_timetable_pages() end
unless opts[:p].nil? then get_professor_list() end
# OptionParser.new do |opts|
#   opts.banner = 'Usage: timeparser.rb [directory_path]'

#   opts.on('-d', '--directory DIR', 'Directory Path') { |d| parse_files_in_folder(d) }
#   opts.on('-a', '--get all', 'Get All Pages') {|a| get_timetable_pages() }
#   opts.on('-g', '--get START_FROM', 'Get Pages') { |g| get_timetable_pages(g) }
#   opts.on('-p', '--professors', 'Get Professor List') { |g| get_professor_list() }
# end.parse!
