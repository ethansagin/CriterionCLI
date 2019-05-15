require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
  #Scraper.movies_scraper
  
  html = open("https://www.criterion.com/films/1333-2-or-3-things-i-know-about-her")
  doc = Nokogiri::HTML(html)
  duration = doc.css("ul.film-meta-list li")[3].text
  
  

  #document.querySelectorAll("ul.film-meta-list")[0].querySelectorAll("li meta")[0].attributes[1].textContent
  end
  
end