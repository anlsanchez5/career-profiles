require 'pry'
class CareerProfiles::CLI
  def run
    puts ""
    puts "Retrieving career data for you..."

    make_career_interests
    add_occupations_to_career_interests
    add_attributes_to_occupations
    start
  end

  def start
    welcome
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
      attributes_hash ||= CareerProfiles::Scraper.scrape_occupation_attributes(occupation.url)
      occupation.add_attributes(attributes_hash)
    end
  end

  def welcome
    puts ""
    puts "Welcome to Occupation Profiles by Career Interests"
    puts ""
  end

  def career_interest
    CareerProfiles::CareerInterest.list_career_interests

    puts ""
    puts "Enter the number of the career interest you'd like to see occupations on or type exit:"

    @input1 = gets.strip

    if @input1.to_i > 0 && @input1.to_i <= CareerProfiles::CareerInterest.all.length
      @selected_career_interest = CareerProfiles::CareerInterest.find(@input1)
      @selected_career_interest.list_occupations
    elsif @input1.downcase == "exit"
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

    @input2 = gets.strip.downcase

    if @input2.to_i > 0 && @input2.to_i <= @selected_career_interest.occupations.length
      @selected_career_interest.occ_find(@input2).display_occupation
    elsif @input2.downcase == "back"
      start
    elsif @input2.downcase == "exit"
      goodbye
      exit
    else
      puts ""
      puts "Not sure what you want."
      @selected_career_interest.list_occupations
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
