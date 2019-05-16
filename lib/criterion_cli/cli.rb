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

end