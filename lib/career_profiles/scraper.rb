require'pry'
class CareerProfiles::Scraper
  def self.get_page
    Nokogiri::HTML(open("https://www.bls.gov/k12/content/students/careers/career-exploration.htm"))
  end

#  def self.scrape_page_index
#    get_page.css("div.careerCol p.careerList")
#  end

  def self.scrape_careers
    names = []
    names_index = get_page.css("div.careerCol p.careerList")
    names_index.each do |c|
      names << c.text
    end
    names.map! do |c|
      c.gsub("[+] Show]", "")
    end

  #  urls = []
  #  scrape_page_index.each do |c|
  #    urls << c.css("a").attribute("href").text
  #    end
  #    urls.each do |u|
  #      u.insert(0,"https://learn.org")
  #    end

    careers = []
    names.each {|name| careers << {:name => name}}
  #  u = 0
  #  urls.each {|url| careers[u][:url] = url; u += 1}
    careers
  end

#  def self.get_career_page(link)
#    Nokogiri::HTML(open(link))
#  end

#  def self.scrape_career_page_index(link)
#    get_career_page(link).css("div#articleContent h4")
#  end

  def self.scrape_occupations(i)
    names = []
    career_index = get_page.css("div.careerNames ul")[i].css("a")
    career_index.each do |o|
      names << o.text
    end
    names.delete_if {|x| x == "Designer"}
#    list.pop
#    names = []
#    list.each do |o|
#      names << o[/[^:]+/]
#    end

    urls = []
    career_index.each do |o|
      urls << o.attribute("href").text
    end
    urls.delete_if {|x| x == "https://www.bls.gov/ooh/arts-and-design/home.htm"}
#    urls.pop
#    urls.each do |u|
#      u.insert(0,"https://learn.org")
#    end

    occupations = []
    names.each {|name| occupations << {:name => name}}
    u = 0
    urls.each {|url|  occupations[u][:url] = url; u += 1}
    occupations
  end

  def self.get_occupation_page(link)
    Nokogiri::HTML(open(link))
  end

#  def self.scrape_occupation_page_index(link)
#    get_occupation_page(link).css("table.quickfacts tbody tr")
#  end

  def self.scrape_occupation_attributes(link)
    index = get_occupation_page(link).css("table#quickfacts tbody tr")
    pay_index = index[0]
    med_pay = pay_index.css("td").text.strip
    med_pay = med_pay.gsub(" ", "")

    education_index = index[1]
    education = education_index.css("td").text.strip

    outlook_index = index[5]
    outlook_2016_26 = outlook_index.css("td").text.strip

    role_index = get_occupation_page(link).css("article")
    role = role_index.css("p")[1].text

    occupation_attributes = {
      :median_pay_2017 => med_pay,
      :education => education,
      :outlook_2016_26 => outlook_2016_26,
      :key_responsibilities => role,
    }

    occupation_attributes
  end


end
