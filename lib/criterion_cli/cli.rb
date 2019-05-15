require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
  #Scraper.movies_scraper
  
  html = open("https://www.criterion.com/films/1333-2-or-3-things-i-know-about-her")
  doc = Nokogiri::HTML(html)
  duration = doc.css("ul.film-meta-list li")[3].text
  color = doc.css("ul.film-meta-list li")[4].text
  language = doc.css("ul.film-meta-list li")[6].text.strip

  cast_hsh = {}
  cast_k = []
  cast_v = []
  doc.css("dl.creditList")[0].css("dt span").each do |x|
    cast_k << x.text
  end
  doc.css("dl.creditList")[0].css("dd span").each do |y|
    cast_v << y.text
  end
  cast_v.each_with_index do |v, i|
    cast_hsh[cast_k[i]] = v
  end
    
  crew_hsh = {}
  crew_k = []
  crew_v = []
  doc.css("dl.creditList")[1].css("dt span").each do |x|
    crew_v << x.text
  end
  doc.css("dl.creditList")[1].css("dd").each do |y|
    crew_k << y.text
  end
  crew_v.each_with_index do |v, i|
    crew_hsh[crew_k[i]] = v
  end


  

  #document.querySelectorAll("ul.film-meta-list")[0].querySelectorAll("li meta")[0].attributes[1].textContent
  end
  
end