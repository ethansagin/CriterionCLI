class Scraper

  def self.movies_scraper
    comp_array = self.collection_scraper
    html = open("https://www.criterion.com/shop/browse/list")
    doc = Nokogiri::HTML(html)
    doc.css("tr.gridFilm").each do |film|
      title = film.css("a").text.strip
      director = film.css("td.g-director").text.strip
      country = film.css("td.g-country").text.strip.gsub(",", "")
      year = film.css("td.g-year").text.strip.gsub(" ", "")
      url = film.attr("data-href")
      unless comp_array.include?(title)
      # needed to prevent anthologies from being instantiated as Movie objects
        mov = Movie.new
        mov.title = title
        mov.director = director
        mov.country = country
        mov.year = year
        mov.url = url
      end
    end
  end

  def self.collection_scraper
    html = open("https://www.criterion.com/shop/browse/list?popular=collectors-sets")
    doc = Nokogiri::HTML(html)
    doc.css("tr.gridFilm").map do |film|
      film.css("a").text.strip
    end
  end

  def self.movie_info_scraper(mov)
    html = open(mov.url)
    doc = Nokogiri::HTML(html)

    mov.duration = doc.css("ul.film-meta-list li")[3].text
    mov.color = doc.css("ul.film-meta-list li")[4].text
    mov.language = doc.css("ul.film-meta-list li")[6].text.gsub(/\s+/, "").gsub(",", "/")
    mov.summary = doc.css("div.product-summary p").text
  
    if doc.css("dl.creditList").length == 2
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
      mov.cast = cast_hsh

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
      mov.crew = crew_hsh
    else
      cast_hsh = {}
      cast_hsh["No cast"] = "no characters"
      mov.cast = cast_hsh
      
      crew_hsh = {}
      crew_k = []
      crew_v = []
      doc.css("dl.creditList").css("dt span").each do |x|
        crew_v << x.text
      end
      doc.css("dl.creditList").css("dd").each do |y|
        crew_k << y.text
      end
      crew_v.each_with_index do |v, i|
        crew_hsh[crew_k[i]] = v
      end
      mov.crew = crew_hsh
    end
  end

end