class CareerProfiles::Occupation
  attr_accessor :name, :url, :median_pay_2017,:education,:outlook_2016_26,  :key_responsibilities
  @@all = []

  def self.all
    @@all
  end

  def initialize(occupation_hash)
    occupation_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.new_from_collection(occupation_array)
    occupation_array.collect{|occupation_hash| self.new(occupation_hash)}
  end

  def add_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def display_occupation
    puts " "
    puts "NAME: #{self.name}"
    puts "------------------------"
    puts " "
    puts "KEY RESPONSIBILITIES"
    puts "----------------------"
    puts "#{self.key_responsibilities}"
    puts " "
    puts "EDUCATION REQUIRED"
    puts "----------------------"
    puts "#{self.education}"
    puts " "
    puts "JOB OUTLOOK 2016-2026"
    puts "----------------------"
    puts "#{self.outlook_2016_26}"
    puts " "
    puts "2017 MEDIAN PAY"
    puts "----------------------"
    puts "#{self.median_pay_2017}"
    puts ""
    puts "For more information and video click here: #{self.url}"
  end
end
