class CareerProfiles::Occupation
  attr_accessor :name, :url, :overview, :work_environment, :education, :pay, :job_outlook
  @@all = []

  def self.all
    @@all
  end

  def initialze(occupation_hash)
    occupation_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.new_from_collection(occupation_array)
    occupation_array.each{|occupation_hash| self.new(occupation_hash)}
  end

  def add_occupation_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def display_occupation
  end
end
