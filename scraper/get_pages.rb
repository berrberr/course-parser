require 'nokogiri'
require 'open-uri'

module Pages
  @base_url = 'http://registrar.mcmaster.ca/CALENDAR/current/'
  @start_page = 'http://registrar.mcmaster.ca/CALENDAR/current/pg4.html'
  @pages_dir = 'pages/'
  def self.get_links
    links = []
    doc = Nokogiri::HTML(open(@start_page))
    doc.css('td.sideMenuLevel2').each do |page|
      links << page.children[0]['href']
    end

    return links
  end

  def self.download_pages
    timestamp = Time.now.strftime('%d%m%Y-%H%M')
    i = 0
    get_links.each do |page|
      i = i + 1
      url = @base_url + page
      File.write(@pages_dir + timestamp + '/' + page, open(url).read)
      puts 'Saved: ' + url + ' Pagenum: ' + i.to_s
    end
  end
end

puts Pages.download_pages()