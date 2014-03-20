require 'mechanize'
require 'nokogiri'
require 'fileutils'

# create Mechanize instance
a = Mechanize.new
a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# get the subject codes from the tt page
ttPage = a.get("https://adweb.cis.mcmaster.ca/mtt/")
ttForm = ttPage.form('MTTSearch')

subjects = []
courses = ['1AA3', '2AA3']
doc = Nokogiri::HTML(ttPage.body)
doc.css('select[name=subject]').css('option').each do |subject|
  if(subject['value'] != 'all') then subjects << subject['value'] end
end

i = 0
if(!subjects.empty?) then
  if(i < 6) then
    i = i + 1
    puts i
    subjects.each do |subject_code|
      courses.each do |course_code|
        ttForm.course = course_code
        ttForm.subject = subject_code
        resp = a.submit(ttForm, ttForm.buttons.first)

        tt_doc = Nokogiri::HTML(resp.body)
        if(!doc.css('a[target=details]').empty?) then
          courseHref = doc.css('a[target=details]')[0]['href']
          puts courseHref
          # coursePage = a.get('https://adweb.cis.mcmaster.ca/mtt/')

          # fPath = 'courses/' + subject_code + '/' + course_code + '.html'
          # dirname = File.dirname(fPath)
          # unless File.directory?(dirname)
          #   FileUtils.mkdir_p(dirname)
          # end

          # File.write(fPath, resp.body)
          # puts 'Wrote: ' + fPath
        end
      end
    end
  end
end


# submit login form
#resp = a.submit(ttForm, ttForm.buttons.first)
#puts resp.body