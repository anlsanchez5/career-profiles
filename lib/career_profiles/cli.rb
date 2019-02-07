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
    CareerProfiles::Career.all.each.with_index do |career, i|
      occupation_hash ||= CareerProfiles::Scraper.scrape_occupations(i)
      career.add_occupations(occupation_hash)
    end
  end

  def add_attributes_to_occupations
    CareerProfiles::Occupation.all.each do |occupation|
      attributes_hash = CareerProfiles::Scraper.scrape_occupation_attributes(occupation.url)
      occupation.add_attributes(attributes_hash)
    end
  end

  def list_careers
    puts "Welcome to Occupation Profiles by Career"
    @careers = CareerProfiles::Career.all
    @careers.each.with_index(1) do |career, i|
      puts "#{i}. #{career.name}"
    end
  end

    def career
      list_careers
      puts ""
      puts "Enter the number of the career you'd like to see occupations on or type exit:"
      @input << gets.strip
      if @input.last.to_i > 0 && @input.last.to_i <= @careers.length.to_i
        @careers[@input.last.to_i-1].list_occupations
      elsif @input.last.downcase == "exit"
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
      if @input.last.to_i > 0 && @input.last.to_i <= occupations.length.to_i
        occupations[@input.last.to_i-1].display_occupation
      elsif @input.last.downcase == "back"
        start
      elsif @input.last.downcase == "exit"
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
