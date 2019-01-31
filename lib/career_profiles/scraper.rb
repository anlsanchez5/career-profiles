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

  def self.get_career_page(link)
    Nokogiri::HTML(open(link))
  end

  def self.scrape_career_page_index(link)
    get_career_page(link).css("div.mainContent table td a")
  end

  def self.scrape_occupations(link)
    names = []
    scrape_career_page_index(link).each do |n|
      names << n.text
    end
    names.delete("")

    urls = []
    scrape_career_page_index(link).each do |u|
      urls << u['href']
    end
    urls.each do |u|
      u.insert(0,"http://www.careerprofiles.info/")
    end

    summary_index = get_career_page(link).css("div.mainContent table")
    summaries = []
    i = 1
    summary_index.each do |s|
      si = s.css("tr")[i]
      summaries << si.css("td")[1].text
      i += 1
    end

    educations = []
    i = 1
    summary_index.each do |s|
      educations << s.css("tr")[i].css("td")[2].text
      i += 1
    end
    median_pays = []
    i = 1
    summary_index.each do |s|
      median_pays << s.css("tr")[i].css("td")[3].text
      i += 1
    end


    occupations = []
    names.each {|name| occupations << {:name => name}}
    u = 0
    urls.each {|url|  occupations[u][:url] = url; u += 1}
    s = 0
    summaries.each {|summary| occupations[s][:summary] = summary; s += 1}
    e = 0
    educations.each {|education| occupations[e][:education] = education; e += 1}
    mp = 0
    median_pays.each{|median_pay| occupations[mp][:median_pay_2018] = median_pay; mp += 1}
    occupations
  end


  def self.add_attributes_to_occupations(link)
    summary_index = get_career_page(link)
  end


end
