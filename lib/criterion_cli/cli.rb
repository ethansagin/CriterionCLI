require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
  Scraper.new.movies_scraper

  end
  
end