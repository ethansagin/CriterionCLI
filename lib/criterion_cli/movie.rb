class Movie
  attr_accessor :title, :director, :country, :year
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all 
  end
  
end