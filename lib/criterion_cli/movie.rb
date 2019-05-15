class Movie
  attr_accessor :title, :country, :year, :url, :duration, :color, :language, :cast, :crew, :summary
  attr_reader :director
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def director=(dir)
    @director = Director.find_or_create_by_name(dir)
  end
  
  def self.all
    @@all 
  end
  
end