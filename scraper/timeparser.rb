require 'mechanize'
require 'nokogiri'
require 'fileutils'

#URL for timetable page
MTTURL = "https://adweb.cis.mcmaster.ca/mtt/"


def getTimetablePages()

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
          tt_doc = Nokogiri::HTML(resp.body)

          #check if there is a link to the course page
          #courseLinks = tt_doc.css('a[target=details]')
          courseLink = resp.link_with(:text => course_code)
          if(!courseLink.nil?) then
            # courseHref = MTTURL + courseLinks[0]['href']
            # puts "#{subject_code}-#{course_code} href: #{courseHref.inspect}"
            # coursePage = a.get(courseHref)
            coursePage = courseLink.click

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

getTimetablePages()
