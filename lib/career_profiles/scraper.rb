require'pry'
class CareerProfiles::Scraper
  def self.get_page
    Nokogiri::HTML(open("https://learn.org/article_directory/Career_Profiles.html"))
  end

  def self.scrape_page_index
    get_page.css("div#articleContent h3.subCatTitle")
  end

  def self.scrape_careers
    list = []
    scrape_page_index.each do |c|
      list << c.css("a").text
    end
    names = []
    list.map! do |c|
      names << c.gsub("Career Profiles", "")
    end


    urls = []
    scrape_page_index.each do |c|
      urls << c.css("a").attribute("href").text
      end
      urls.each do |u|
        u.insert(0,"https://learn.org")
      end

    careers = []
    names.each {|name| careers << {:name => name}}
    u = 0
    urls.each {|url| careers[u][:url] = url; u += 1}
    careers
  end

  def self.get_career_page(link)
    Nokogiri::HTML(open(link))
  end

  def self.scrape_career_page_index(link)
    get_career_page(link).css("div#articleContent h4")
  end

  def self.scrape_occupations(link)
    list = []
    scrape_career_page_index(link).each do |o|
      list << o.css("a").text
    end
    list.pop
    names = []
    list.each do |o|
      names << o[/[^:]+/]
    end

    urls = []
    scrape_career_page_index(link).each do |o|
      urls << o.css("a").attribute('href').text
    end
    urls.pop
    urls.each do |u|
      u.insert(0,"https://learn.org")
    end

    occupations = []
    names.each {|name| occupations << {:name => name}}
    u = 0
    urls.each {|url|  occupations[u][:url] = url; u += 1}
    occupations
  end

  def self.get_occupation_page(link)
    Nokogiri::HTML(open(link))
  end

  def self.scrape_occupation_page_index(link)
    get_occupation_page(link).css("div.wikiContent")
  end

  def self.scrape_occupation_attributes(link)
    summary = scrape_occupation_page_index(link).css("p")[0].text

    degree_required = scrape_occupation_page_index(link).css("table.wikitable tr")[0].css("td")[1].text
binding.pry
    field_of_study = scrape_occupation_page_index(link).css("table.wikitable tr")[1].css("td")[1].text

    key_responsibilities = scrape_occupation_page_index(link).css("table.wikitable tr")[2].css("td")[1].text

  #  licensure = scrape_occupation_page_index(link).css("table.wikitable tr")[3].css("td")[1].text

  #  job_growth2014_2024 = scrape_occupation_page_index(link).css("table.wikitable tr")[4].css("td")[1].text

  #  average_salary_2015 = scrape_occupation_page_index(link).css("table.wikitable tr")[5].css("td")[1].text

    occupation_attributes = {
      :summary => summary,
      :degree_required => degree_required,
      :field_of_study => field_of_study,
      :key_responsibilities => key_responsibilities,
      #:licensure => licensure,
      #:job_growth2014_2024 => job_growth2014_2024,
      #:average_salary_2015 => average_salary_2015
    }

    occupation_attributes
  end


end
