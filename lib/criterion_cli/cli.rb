require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
    Scraper.movies_scraper
    # print movie profile
    # show what films director has made
    # show who director has collaborated with
    # list all directors
    # list all movies
    puts "Welcome to Criterion Collection List"
    puts ""
    puts "1) List all Criterion Directors."
    puts "2) List all Criterion Films."
    puts "exit) Exit program"
    input = ""
    while input != "0"
      input = gets.strip.downcase
      case input
      when "1"
        list_directors
      when "2"
        list_films
      end
    end
    puts "Goodbye!"
  end

  def film_profile
    
  end

  def list_directors
    Director.all.each_with_index do |dir, index|
      puts "#{index + 1}) #{dir.name}"
    end
  end
  
  def list_films
    Movie.all.each_with_index do |movie, index|
      puts "#{index + 1}) #{movie.title}"
    end
  end
  
  def list_films_by_director
    
  end
  
end