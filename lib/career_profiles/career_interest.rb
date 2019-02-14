require 'pry'
class CareerProfiles::CareerInterest
  attr_accessor :name, :occupations
  @@all = []

  def initialize(career_interest_hash)
    career_interest_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.new_from_collection(career_interest_array)
    career_interest_array.each {|career_interest_hash| self.new(career_interest_hash)}
  end

  def self.all
    @@all
  end

  def self.find(i)
    all[i.to_i-1]
  end

  def occ_find(i)
    @occupations[i.to_i-1]
  end

  def add_occupations(occupation_hash)
    occupation = CareerProfiles::Occupation.new_from_collection(occupation_hash)
    @occupations = occupation
  end

  def list_occupations
    puts ""
    @occupations.each.with_index(1) do |occupation, i|
      puts "#{i}. #{occupation.name}"
    end
  end
end
