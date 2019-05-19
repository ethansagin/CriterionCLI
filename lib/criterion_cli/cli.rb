require 'pry'
require 'open-uri'
require 'nokogiri'

class CriterionCli::Cli
  
  def call
    Scraper.movies_scraper
    puts "      _ _ _ _ _ _ _ _"
    puts "     / _ _ _ _ _ _ _ \ "
    puts "    / /             \ \ " 
    puts "   / /               \ \ "
    puts "  | |                 \/ "
    puts "  | | "
    puts "  | | "
    puts "  | | "          
    puts "  | | "
    puts "  | | "
    puts "   \ \ "
    puts "    \ \_ _ _ _"
    puts "     \ _ _ _ _\ "
    puts ""           
    puts "  Welcome to the Criterion Collection Catalog!"
    start
  end
  
  def start
    input = nil
    while input != "exit"
      puts main = <<~end
          
          MAIN MENU
          - To browse the list of titles, enter 'list titles'
          - To browse the list of directors, enter 'list directors'
          - To browse the list of titles by decade, enter 'list years'
          - To browse the list of titles by country, enter 'list countries'
          - To exit this program, enter 'exit'
      end
      input = gets.strip.downcase
      case input
      when "list titles"
        list_titles
      when "list directors"
        list_directors
      when "list countries"
        list_countries
      when "list years"
        list_years
      when "exit"
        puts goodbye = <<~end
        
          Thank you for using CCC, enjoy the show!

                    @@
                  @ @  @  @@ @ @
                @ @ @ @ @ @ @ @ @
              _@_@_@_@_ @@ _@_@_@_@_
              ||| ||| ||@ @|| ||| ||| @
              ||| ||| ||---|| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
              ||| ||| ||| ||| ||| |||
        @     |||_|||_|||_|||_|||_|||  @  @@  @

          
        end
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end
  
###List Titles Path
  
  def list_titles
    input = nil
    while input != "menu"
      puts titles = <<~end
    
        Movie Titles (Full Catalog) Menu
        - To browse the catalog, enter a page number between '1' and '#{(Movie.all.length/100.to_f).ceil}'
        - To view a movie profile, enter 'view'
        - To return to the previous menu, enter 'menu'
      end
      input = gets.strip.downcase
      if input == "menu"
      elsif input.to_i > 0 && input.to_i <= ((Movie.all.length/100.to_f).ceil)
        Movie.all.each_with_index do |movie, index|
          if index >= (input.to_i - 1)*100 && index < (input.to_i)*100
            puts "#{index + 1}) #{movie.title}"
          end
        end
      elsif input == "view"
        view_profile
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end
  
  def view_profile
    input = nil
    while input != "menu"
      puts profile = <<~end
  
        Movie Profile Menu
        - To view movie profile, enter the movie number
        - To return to the previous menu, enter 'menu'
      end
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= Movie.all.length + 1
        movie_profile(input.to_i - 1)
      elsif input == "menu"
      else
        puts invalid = <<~end
        
        Invalid selection
        end
      end
    end
  end
  
  def movie_profile(index)
    mov = Movie.all[index]
    Scraper.movie_info_scraper(mov) unless mov.duration
    puts ""
    puts "#{mov.title} (#{mov.year})"
    puts "directed by #{mov.director.name}"
    puts "- - - - - - - - - - - - - - - - - "
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
    puts "A(n) #{mov.language} language film produced in #{mov.country.name}"
    puts "Filmed in #{mov.color}"
    puts "Runtime #{mov.duration}"
    puts "* * * * * * * * * * * * * * * * *"
  end
  
### List Directors Path
  
  def list_directors
    input = nil
    while input != "menu"
      puts directors = <<~end 
    
        Director List Menu
        - To browse the director list, enter a page number between '1' and '#{(Director.all.length/100.to_f).ceil}'
        - For more information on a director, enter 'info'
        - To return to the previous menu, enter 'menu'
      end
      input = gets.strip.downcase
      if input == "menu"
      elsif input.to_i > 0 && input.to_i <= ((Director.all.length/100.to_f).ceil)
        Director.all.each_with_index do |dir, index|
          if index >= (input.to_i - 1)*100 && index < (input.to_i)*100
            puts "#{index + 1}) #{dir.name}"
          end
        end
      elsif input == "info"
        director_info
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end
  
  def director_info
    input = nil
    while input != "menu"
      puts dir_info = <<~end
  
        Director Info Menu
        - To view more information on a director, enter the director number
        - To view the profile of a movie listed in a director profile, enter 'view'
        - To return to the previous menu, enter 'menu'
      end
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i < Director.all.length
        dir = Director.all[input.to_i - 1]
        puts ""
        puts "#{dir.name} Criterion Profile"
        puts "- - - - - - - - - - - - - - - - - "
        puts "#{dir.name} has directed a total of #{dir.movies.length} films"
        puts "in the Criterion Collection:"
        director_info_mov_list(dir)
        puts ""
        puts "Notable actors/actresses with whom #{dir.name}"
        puts "has collaborated on these films include:"
        director_info_cast_collab(dir)
        puts ""
        director_info_other_roles(dir)
        puts ""
      elsif input == "view"
        view_profile
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end

  def director_info_mov_list(dir)
   dir.movies.each do |moovv|
      Movie.all.each_with_index do |mov, index|
        if moovv == mov
          Scraper.movie_info_scraper(mov) unless mov.duration
          puts "#{index + 1}) #{mov.title}"
        end
      end
    end
  end
  
  def director_info_cast_collab(dir)
    cast = []
    dir.movies.each do |mov|
      cast << mov.cast.keys
    end
    cast = cast.flatten.uniq.join(", ")
    puts "#{cast}"
  end
  
  def director_info_other_roles(dir)
    dir_crew = []
    dir.movies.each do |mov|
      mov.crew.each do |k, v|
        if k == dir.name
          dir_crew << v unless v == "Director"
        end
      end
    end
    if dir_crew.length > 0
      dir_crew = dir_crew.map{|role| role.gsub(" by", "")}
      dir_crew = dir_crew.uniq.join(", ")
      puts "Besides directing, #{dir.name} also contributed to some of"
      puts "these films in the following roles:"
      puts "#{dir_crew}"
    end
  end

### Lists Decade Path
  # def list_years
  #   mov_by_yr = Movie.all.sort_by{|mov| mov.year}
  #   puts " -To browse the catalog by year, enter a decade between '1900'"
  #   puts "and '#{mov_by_yr.last.year}'"
  #   binding.pry
  #   puts "Decade List Menu"
  #   puts "- To "
  #   input = gets.strip.downcase
  # end
    
### Lists Country Path
  def list_countries
    input = nil
    while input != "menu"
      puts countries = <<~end
      
        Country List Menu
        - To browse the country list, enter 'list'
        - For more information on a country, enter 'info'
        - To return to the previous menu, enter 'menu'
      end
      input = gets.strip.downcase
      if input == "menu"
      elsif input == "list"
        Country.all.each_with_index do |cty, index|
          puts "#{index + 1}) #{cty.name}"
        end
      elsif input == "info"
        puts ""
        country_info
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end
        
        
  def country_info
    #how many movies
    #what are those movies
    #for more information
    input = nil
    while input != "menu"
      puts cty_info = <<~end
  
        Country Info Menu
        - To view more information on a country, enter the country number
        - To view the profile of a movie listed in a country profile, enter 'view'
        - To return to the previous menu, enter 'menu'
      end
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= Country.all.length
        cty = Country.all[input.to_i - 1]
        puts ""
        puts "#{cty.name} Criterion Profile"
        puts "- - - - - - - - - - - - - - - - - "
        puts "A total of #{cty.movies.length} films have been produced in #{cty.name}:"
        puts ""
        country_info_mov_list(cty)
      elsif input == "view"
        view_profile
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
   end
   
  def country_info_mov_list(cty)
    cty.movies.each do |moovv|
      Movie.all.each_with_index do |mov, index|
        if moovv == mov
          Scraper.movie_info_scraper(mov) unless mov.duration
          puts "#{index + 1}) #{mov.title}"
        end
      end
    end
  end
      
end