require'pry'
class CareerProfiles::Scraper
  def self.get_page
    Nokogiri::HTML(open("http://www.careerprofiles.info/careers.html"))
  end

  def self.scrape_page_index
    get_page.css("div.mainText a")
  end

  def self.scrape_careers
    names = []
    scrape_page_index.each do |c|
      names << c.text
    end

    urls = []
    scrape_page_index.each do |c|
      urls << c.attribute("href").text
      end
      urls.each do |u|
        u.insert(0,"http://www.careerprofiles.info/")
    end

    careers = []
    names.each {|name| careers << {:name => name}}
    u = 0
    urls.each {|url| careers[u][:url] = url; u += 1}
    careers
  end

  def get_career_page(link)
    Nokogiri::HTML(open(link))
  end

  def self.scrape_career_page_index(link)
    get_career_page(link).css("div.mainContent table td")
  end

  def self.scrape_occupations(link)
    names = []
    scrape_career_page_index(link).each do |o|
      names << o.css("a").text
    end
    names.delete("")

  end
end
