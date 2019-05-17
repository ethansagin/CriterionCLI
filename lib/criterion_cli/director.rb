class Director
  attr_accessor :name, :movies
  
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
    Director.all.detect{|dir| dir.name == name}
  end
  
  def self.create_by_name(name)
    Director.new(name).tap{|dir| dir.save}
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create_by_name(name)
  end
  
end