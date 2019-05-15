class Director
  attr_reader :name, :movies
  
  @@all = []
  
  def initialize(name)
    @name = name
    @movies = []
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
  def self.find_by_name(name)
    self.all.detect{|dir| dir.name == name}
  end
  
  def self.create_by_name(name)
    new = Director.new(name)
    new.save
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create_by_name(name)
  end
  
  
end