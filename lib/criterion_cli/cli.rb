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
      puts ""
      puts "MAIN MENU"
      puts "- To browse the list of titles, enter 'list titles'"
      puts "- To exit this program, enter 'exit'"
      input = gets.strip.downcase
      case input
      when "list titles"
        list_titles
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
    puts ""
    puts "- To browse the catalog, enter a page number between '1' and '#{(Movie.all.length/100.to_f).ceil}'"
    puts "- To view a movie profile, enter 'view'"
    puts "- To return to the previous menu, enter 'menu'"
    input = gets.strip.downcase
      if input == "menu"
      elsif input.to_i > 0 && input.to_i <= ((Movie.all.length/100.to_f).ceil)
        Movie.all.each_with_index do |movie, index|
          if index >= (input.to_i - 1)*100 && index < (input.to_i)*100
            puts "#{index + 1}. #{movie.title}"
          end
        end
      elsif input == "view"
        view_profile
      else
        puts "Invalid selection"
        puts ""
      end
    end
  end
  
  def view_profile
    input = nil
    while input != "menu"
      puts ""
      puts "To view movie profile, enter the movie number"
      puts "To return to the previous menu, enter 'menu'"
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
    Scraper.movie_info_scraper(mov) unless mov.duration
    puts ""
    puts "#{mov.title} (#{mov.year}))"
    puts "directed by #{mov.director}"
    puts ""
    puts "#{mov.summary}"
    puts ""
    puts "STARRING"
    mov.cast.each do |k, v|
      puts "#{k} as #{v}"
    end
    puts ""
    mov.crew.each do |k, v|
      puts "#{v}: #{k}"
    end
    puts ""
    puts "A(n) #{mov.language} language film produced in #{mov.country}"
    puts "Filmed in #{mov.color}"
    puts "Runtime #{mov.duration}"
  end
    
    # :title, :director, :country, :year, :url, :duration, :color, :language, :cast, :crew, :summary

end