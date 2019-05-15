require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
  Scraper.movies_scraper
  puts "Welcome"
  puts "To view a list of all Criterion Directors, enter 1."
  puts ""
  # Movie.all.each_with_index do |movie, index|
  #   puts "#{index + 1}) #{movie.title}"
  # end
  

  end
  
end