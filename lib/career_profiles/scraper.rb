require'pry'
class CareerProfiles::Scraper
  BASE_LINK = "https://www.bls.gov/k12/content/students/careers/career-exploration.htm"

  def self.get_page(link)
    Nokogiri::HTML(open(link))
  end

  def self.scrape_career_interests
    names_index = get_page(BASE_LINK).css("div.careerCol p.careerList")
    names = names_index.collect do |career_index|
      career_index.text.gsub("[+] Show", "")
    end

    career_interests = names.collect {|name| {:name => name}}
  end

  def self.scrape_occupations(i)
    career_interest_index = get_page(BASE_LINK).css("div.careerNames ul")[i].css("a")

    names = career_interest_index.collect do |occupation_index|
      occupation_index.text
    end
    names.delete_if {|x| x == "Designer"}

    urls = career_interest_index.collect do |occupation_index|
      occupation_index.attribute("href").text
    end
    urls.delete_if {|x| x == "https://www.bls.gov/ooh/arts-and-design/home.htm"}

    occupations = []
    names.each {|name| occupations << {:name => name}}
    u = 0
    urls.each {|url|  occupations[u][:url] = url; u += 1}
    occupations
  end

  def self.scrape_occupation_attributes(link)
    index = get_page(link).css("table#quickfacts tbody tr")
    pay_index = index[0]
    med_pay = pay_index.css("td").text.strip
    med_pay = med_pay.gsub("\n", ' ').squeeze(' ')

    education_index = index[1]
    education = education_index.css("td").text.strip

    outlook_index = index[5]
    outlook_2016_26 = outlook_index.css("td").text.strip

    role_index = get_page(link).css("article")
    role = role_index.css("p")[1].text

    occupation_attributes = {
      :median_pay_2017 => med_pay,
      :education => education,
      :outlook_2016_26 => outlook_2016_26,
      :key_responsibilities => role,
    }
  end
end
