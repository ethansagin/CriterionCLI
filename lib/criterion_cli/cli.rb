require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
  Scraper.movies_scraper
  puts "Welcome"
  puts "1) List all Criterion Directors."
  puts "2) List all Criterion Films."
  input = nil
  while input =! "exit"
    input = gets.strip.downcase
    case input
      when "1"
        list_directors
      when "2"
        list_films
    end
  end

  

  end
  
  def list_directors
    
  end
  
  def list_films
    puts "1) 1-500"
    puts "2) 501-1000"
    puts "3) 1001-end"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
        when "1"
          Movie.all.each_with_index do |movie, index|
            puts "#{index + 1}) #{movie.title}" if index < 500
          end
        when "2"
          Movie.all.each_with_index do |movie, index|
            puts "#{index + 1}) #{movie.title}" if index >= 500 && index < 501-1000
          end
        when "3"
          Movie.all.each_with_index do |movie, index|
            puts "#{index + 1}) #{movie.title}" if index > 1000
          end
      end
    end
  end
end