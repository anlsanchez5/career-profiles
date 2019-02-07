require 'pry'
class CareerProfiles::Career
  attr_accessor :name, :occupations
  @@all = []

  def initialize(career_hash)
    career_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.new_from_collection(career_array)
    career_array.each {|career_hash| self.new(career_hash)}
  end

  def self.all
    @@all
  end

  def add_occupations(occupation_hash)
    occupation = CareerProfiles::Occupation.new_from_collection(occupation_hash)
    @occupations = occupation   
  end

  def list_occupations
    @occupations.each.with_index(1) do |occupation, i|
      puts "#{i}. #{occupation.name}"
    end
  end




end
