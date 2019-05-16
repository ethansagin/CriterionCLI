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
        view_profile
      when "exit"
        puts "Thank you for using CCC, enjoy the show!"
      else
        puts "Invalid selection"
        puts ""
      end
    end
  end
  
  def list_titles
    input = nil
    while input != "menu"
    puts "Something about inputting numbers"
    input = gets.strip.downcase
      if input == "menu"
      elsif input.to_i > 0 && input.tp_i <= ((Movie.all.length/100.to_f).ceil)
        Movie.all.each_with_index do |movie, index|
          if index >= (input.to_i - 1)*100 && index < (input.to_i)*100
            puts "#{index + 1}. #{movie.title}"
          end
        end
      else
        puts "Invalid selection"
        puts ""
      end
    end
  end
  
  def view_profile
    input = nil
    while input != "menu"
      puts "To view movie profile, enter the movie number"
      puts "To return to the menu, enter 'menu'"
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= Movie.all.length + 1
        movie_profile(input.to_i - 1)
      elsif input == "menu"
      else
        puts "Invalid selection"
        puts ""
      end
    end
  end

  def movie_profile(index)
    mov = Movie.all[index]
    puts "#{mov.title}"
  end
    

end