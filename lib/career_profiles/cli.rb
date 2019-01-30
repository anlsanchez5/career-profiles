require 'pry'
class CareerProfiles::CLI
  def run
    make_careers
    add_occupations_to_careers
    add_attributes_to_occupations
    @input = []
    start
  end

  def start
    career
    occupation
    options
  end

  def make_careers
    career_array ||= CareerProfiles::Scraper.scrape_careers
    CareerProfiles::Career.new_from_collection(career_array)
  end

  def add_occupations_to_careers
    CareerProfiles::Career.all.each do |career|
      occupation_info ||= CareerProfiles::Scraper.scrape_occupations(career.url)
      CareerProfiles::Occupation.new_from_collection(occupation_info)
    end
  end

  def add_attributes_to_occupations
    CareerProfiles::Occupation.all.each do |career|
      attributes = CareerProfiles::Scraper.scrape_occupation_page(career.url)
      career.add_attributes(attributes)
    end
  end

  def list_careers
    puts "Career Profiles and Occupations"
    @careers = CareerProfiles::Career.all
    @careers.each.with_index(1) do |cuisine, i|
      puts "#{i}. #{career.name}"
    end
  end

    def career
      list_careers
      puts ""
      puts "Enter the number of the career you'd like to see occupations on or type exit:"
      @input << get.strip.downcase
      if @input.last.to_i > 0 && @input.last.to_i <= @careers.length.to_i
        @careers[@input.last.to_i-1].list_occupations
      elsif @input.last == "exit"
        goodbye
        exit
      else
        puts ""
        puts "Not sure what you want."
        puts ""
        career
      end
    end

    def occupation
      puts ""
      puts "Enter the number of the occupation you'd like to see, type back to see the career list again or type exit:"
      @input << gets.strip.downcase
      i = @input[(@input.length)-2]
      occupations = @careers[i.to_i-1].occupations
      if @input.last.to_i > 0 && @input.last.to_i <= occupations.lenth.to_i
        occupations[@input.last.to_i-1].display_occupation
      elsif @input.last == "back"
        start
      elsif @input.last == "exit"
        goodbye
        exit
      else
        puts ""
        puts "Not sure what you want."
        @input.pop
        @careers[@input.last.to_i-1].list_occupations
      end
    end

    def options
      puts ""
      puts "Would you like to explore more occupations? Type Y or N:"
      input = gets.strip
      if input == "Y" || input == "y"
        start
      elsif input == "N" || input == "n"
        goodbye
        exit
      else
        puts ""
        puts "Not sure what you want."
        puts ""
        options
      end
    end

    def goodbye
      puts "See you later to explore more occupations!"
    end
end
