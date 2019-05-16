require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
    Scraper.movies_scraper
    puts "Welcome to the Criterion Collection Catalog!"
    start
  end
  
  def start
    input = ""
    while input != "exit"
      puts ""
      puts "To browse the list of titles, enter 'list titles'"
      puts "To browse titles by director, enter 'list directors'"
      puts "To exit this program, enter 'exit'"
      input = gets.strip.downcase
      case input
        when "list titles"
          list_titles
        when "list directors"
          list_directors
        when "exit"
          puts "Thank you for using CC, Happy Watching!"
        else
          puts "Invalid selection"
      end
    end
  end
  
  def list_titles
    Movies.all.each_with_index do |movie, index|
      puts "#{index + 1}. #{movie.name}"
    end
    
    input = ""
    puts "Enter the number of the movie you'd like to see more information about"
    puts "To return to the main menu, enter '0'"
    
    input = gets.strip.to_i
    while input != 0
      movie_profile(input - 1)
    end
  end
  
  def list_directors
    
  end
  
  def movie_profile(movie_index)
    mov = Movie.all[movie_index]
    puts "#{mov.title}"
  end
  
  

end