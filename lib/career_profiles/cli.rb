require 'pry'
class CareerProfiles::CLI
  def run
    puts "Loading data..."
    make_career_interests
    add_occupations_to_career_interests
    add_attributes_to_occupations
    @input = []
    start
  end

  def start
    career_interest
    occupation
    options
  end

  def make_career_interests
    career_interest_array ||= CareerProfiles::Scraper.scrape_career_interests
    CareerProfiles::CareerInterest.new_from_collection(career_interest_array)
  end

  def add_occupations_to_career_interests
    CareerProfiles::CareerInterest.all.each.with_index do |career_interest, i|
      occupation_hash ||= CareerProfiles::Scraper.scrape_occupations(i)
      career_interest.add_occupations(occupation_hash)
    end
  end

  def add_attributes_to_occupations
    CareerProfiles::Occupation.all.each do |occupation|
      attributes_hash = CareerProfiles::Scraper.scrape_occupation_attributes(occupation.url)
      occupation.add_attributes(attributes_hash)
    end
  end

  def list_career_interests
    puts "Welcome to Occupation Profiles by Career Interests"
    @career_interests = CareerProfiles::CareerInterest.all
    @career_interests.each.with_index(1) do |career_interest, i|
      puts "#{i}. #{career_interest.name}"
    end
  end

    def career_interest
      list_career_interests
      puts ""
      puts "Enter the number of the career interest you'd like to see occupations on or type exit:"
      @input << gets.strip
      if @input.last.to_i > 0 && @input.last.to_i <= @career_interests.length.to_i
        @career_interests[@input.last.to_i-1].list_occupations
      elsif @input.last.downcase == "exit"
        goodbye
        exit
      else
        puts ""
        puts "Not sure what you want."
        puts ""
        career_interest
      end
    end

    def occupation
      puts ""
      puts "Enter the number of the occupation you'd like to see, type back to see the career interest list again or type exit:"
      @input << gets.strip.downcase
      i = @input[(@input.length)-2]
      occupations = @career_interests[i.to_i-1].occupations
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
        @career_interests[@input.last.to_i-1].list_occupations
        occupation
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
