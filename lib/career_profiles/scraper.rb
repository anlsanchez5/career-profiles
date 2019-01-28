require'pry'
CareerProfiles::Scraper
  def self.get_page
    Nokogiri::HTML(open(""))
  end

  def self.scrape_page_index
    get_page.css("a")
  end

  def self.scrape_careers
    names = []
    scrape_page_index.each do |c|
      names << c.css("")
    end

    urls = []
    scrape_page_index.each do |c|
      urls << c.attribute("").text
    end

    careers = []
    names.each {|name| careers << {:name => name}}
    u = 0
    urls.each {|url| career[u][:url] = url; u += 1}
    careers
  end
  
end
