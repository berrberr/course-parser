require 'mechanize'
require 'nokogiri'
require 'fileutils'
require 'optparse'

#URL for timetable page
MTTURL = "https://adweb.cis.mcmaster.ca/mtt/"


def get_timetable_pages()

  #create Mechanize instance
  a = Mechanize.new
  a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #get the subject codes from the tt page
  ttPage = a.get(MTTURL)

  subjects = []
  courses = ['2AA3', '1AA3']
  doc = Nokogiri::HTML(ttPage.body)
  doc.css('select[name=subject]').css('option').each do |subject|
    if(subject['value'] != 'all') then subjects << subject['value'] end
  end

  i = 0
  if(!subjects.empty?) then
    #each subject code
    subjects.each do |subject_code|
      if(i < 3) then
        i = i + 1
        #each course for that subject
        courses.each do |course_code|

          #get the TT main page, get the form from it, submit contents
          ttPage = a.get(MTTURL)
          ttForm = ttPage.form('MTTSearch')
          ttForm.course = course_code
          ttForm.subject = subject_code
          resp = a.submit(ttForm, ttForm.buttons.first)

          #check if there is a link to the course page
          courseLink = resp.link_with(:text => course_code)
          if(!courseLink.nil?) then
            # courseHref = MTTURL + courseLinks[0]['href']
            # puts "#{subject_code}-#{course_code} href: #{courseHref.inspect}"
            # coursePage = a.get(courseHref)
            coursePage = courseLink.click
            coursePageDoc = Nokogiri::HTML(coursePage.body)

            #write the contents of the course page to a file for parsing later
            fPath = 'courses/' + subject_code + '/' + course_code + '.html'
            dirname = File.dirname(fPath)
            unless File.directory?(dirname)
             FileUtils.mkdir_p(dirname)
            end

            File.write(fPath, coursePage.body)
            puts 'Wrote: ' + fPath
          end
        end
      end
    end
  end
end

def check_course_exists(course_code, subject_code)
  puts "COURSE: " + course_code.inspect + "  SUBJ: " + subject_code
  return true
end

def parse_file(filename)
  puts 'Parsing: ' + filename
  f = File.open(filename)
  doc = Nokogiri::HTML(f)
  output = {}
  i = 1

  courseHeader = doc.xpath('//table//tr[contains(., "Course Offering")]')
  subjectCode = courseHeader.css('td:nth-child(2)').text.gsub(/\s+/, "")
  courseCode = courseHeader.css('td:nth-child(3)').text.gsub(/\s+/, "")

  if(check_course_exists(courseCode, subjectCode)) then
    doc.xpath('//table[.//th[contains(., "Status")]]//tr').each do |tr|
      if(i >= 4) then #the course timetable rows start at the 4th tr
        puts "Days: #{tr.css('td:nth-child(3)')}\nTimes: #{tr.css('td:nth-child(4)')}"
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

OptionParser.new do |opts|
  opts.banner = 'Usage: timeparser.rb [directory_path]'

  opts.on('-d', '--directory DIR', 'Directory Path') { |d| parse_files_in_folder(d) }
  opts.on('-g', '--get', 'Get Pages') { |g| get_timetable_pages() }
end.parse!
