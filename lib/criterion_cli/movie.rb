class Movie
  attr_accessor :title, :director, :country, :year, :url, :duration, :color, :language, :cast, :crew, :summary

  @@all = []
  
  def initialize
    @@all << self
  end
  
  def director=(dir)
    @director = Director.find_or_create_by_name(dir)
    self.director.add_movie(self)
  end
  
  def self.all
    @@all 
  end
  
  def self.find(id)
    self.all[id-1]
  end
  
end