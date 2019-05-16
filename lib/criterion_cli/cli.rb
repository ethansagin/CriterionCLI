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
    input = nil
    while input != "exit"
      puts "To browse the list of titles, enter 'list titles'"
      puts "To exit this program, enter 'exit'"
      input = gets.strip.downcase
      case input
      when "list titles"
        list_titles
      else
        puts "Invalid selection"
        puts ""
      end
    end
    puts "Thank you for using CC, enjoy the show!"
  end
  
  def list_titles
    Movie.all.each_with_index do |movie, index|
      puts "#{index + 1}. #{movie.title}"
    end
  end
  
  def movie_profile(movie_index)
    mov = Movie.all[movie_index]
    puts "#{mov.title}"
  end

end