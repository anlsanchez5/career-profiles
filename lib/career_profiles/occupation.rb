class CareerProfiles::Occupation
  attr_accessor :name, :url, :summary, :degree_required, :field_of_study, :key_responsibilities
  @@all = []

  def self.all
    @@all
  end

  def initialize(occupation_hash)

    occupation_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.new_from_collection(occupation_array)
    occupation_array.each{|occupation_hash| self.new(occupation_hash)}
  end

  def add_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def display_occupation
  end
end
