require'pry'
class CareerProfiles::Scraper
  def self.get_page
    Nokogiri::HTML(open("https://www.bls.gov/k12/content/students/careers/career-exploration.htm"))
  end

  def self.scrape_career_interests
    list = []
    names_index = get_page.css("div.careerCol p.careerList")
    names_index.each do |c|
      list << c.text
    end
    names = []
    list.each do |c|
      names << c.gsub("[+] Show", "")
    end


    career_interests = []
    names.each {|name| career_interests << {:name => name}}
    career_interests
  end

  def self.scrape_occupations(i)
    names = []
    career_interest_index = get_page.css("div.careerNames ul")[i].css("a")
    career_interest_index.each do |o|
      names << o.text
    end
    names.delete_if {|x| x == "Designer"}

    urls = []
    career_interest_index.each do |o|
      urls << o.attribute("href").text
    end
    urls.delete_if {|x| x == "https://www.bls.gov/ooh/arts-and-design/home.htm"}

    occupations = []
    names.each {|name| occupations << {:name => name}}
    u = 0
    urls.each {|url|  occupations[u][:url] = url; u += 1}
    occupations
  end

  def self.get_occupation_page(link)
    Nokogiri::HTML(open(link))
  end

  def self.scrape_occupation_attributes(link)
    index = get_occupation_page(link).css("table#quickfacts tbody tr")
    pay_index = index[0]
    med_pay = pay_index.css("td").text.strip
    med_pay = med_pay.gsub("\n", ' ').squeeze(' ')

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
