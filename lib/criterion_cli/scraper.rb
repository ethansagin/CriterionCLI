require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  def movies_scraper
    html = open("https://www.criterion.com/shop/browse/list")
    doc = Nokogiri::HTML(html)
    doc.css("tr.gridFilm").each do |film|
      title = film.css("a").text.strip
      director = film.css("td.g-director").text.strip
      country = film.css("td.g-country").text.strip.gsub(",", "")
      year = film.css("td.g-year").text.strip
      if country != ""
        mov = Movie.new
        mov.title = title
        mov.director = director
        mov.country = country
        mov.year = year
      end
    end
  end
  
  def movie_info_scraper
  end
end