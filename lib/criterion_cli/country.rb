class Country
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
  
  def add_movie(mov)
    mov.country ||= self
    @movies << mov unless @movies.include?(mov)
  end
  
  def self.find_by_name(name)
    Country.all.detect{|cty| cty.name == name}
  end
  
  def self.create_by_name(name)
    Country.new(name).tap{|cty| cty.save}
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create_by_name(name)
  end
  
end