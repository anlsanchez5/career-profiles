require 'pry'
class CareerProfiles::Career
  attr_accesor :name, :url, :occupations
  @@all = []

  def initialze(career_hash)
    career_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all.self
  end

  def self.new_from_collection(career_array)
    career_array.each {|career_hash| self.new(career_hash)}
  end

  def self.all
    @@all
  end

  def add_occupations
    CareerProfiles::Occupation.new_from_collection(occupation_hash)
  end

  def list_occupations
    @occupations.each.with_index(1) do |occupation, i|
      puts "#{i}. #{occupation.name}"
    end
  end

  


end
