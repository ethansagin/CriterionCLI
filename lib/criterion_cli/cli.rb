require 'pry'
class Cli
  
  def call
    Scraper.movies_scraper
    puts ""           
    puts "WELCOME TO THE CRITERION COLLECTION CATALOG!"
    start
  end
  
  def start
    input = nil
    while input != "exit"
      puts main = <<~end
          
          MAIN MENU
          - Enter 'list titles' to go to the Movie Titles Menu
          - Enter 'list directors' to go to the Movie Directors Menu
          - Enter 'list years' to go to the Decade List Menu
          - Enter 'list countries' to go to the Country List Menu
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
    input = 1
    puts ""
    puts "You are viewing page #{input} of movie titles."
    print_movies(input)
    while input != "main"
      puts titles = <<~end

        MOVIE TITLES 
        - Enter a number between '1' and '#{(Movie.all.length/100.to_f).ceil}' to view another page of titles
        - Enter 'view #' to view the profile of a specific movie
            (Ex. 'view 5' will display the profile for the fifth movie listed)
        - Enter 'main' to return to the main menu
      end
      input = gets.strip.downcase
      if input == "main"
      elsif input.to_i > 0 && input.to_i <= ((Movie.all.length/100.to_f).ceil)
        print_movies(input)
        puts ""
        puts "You are viewing page #{input} of movie titles."
      elsif /^view\s\d*$/.match(input)
        view_profile?(input)
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end
  
  def print_movies(input)
    Movie.all.each_with_index do |movie, index|
      if index >= (input.to_i - 1)*100 && index < (input.to_i)*100
        puts "#{index + 1}) #{movie.title}"
      end
    end
  end
  
  def view_profile?(input)
    num = input.gsub("view", "")
    if num.to_i > 0 && num.to_i <= Movie.all.length
      movie_profile(num.to_i - 1)
    else 
      puts invalid = <<~end
    
      Invalid selection
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
    input = 1
    print_directors(input)
    puts ""
    puts "You are viewing page #{input} of directors."
    while input != "main"
      puts directors = <<~end 
    
        DIRECTORS LIST
        - Enter a number between '1' and '#{(Director.all.length/100.to_f).ceil}' to view another page of directors
        - Enter 'info #' for more information on a specific director
            (Ex. 'info 3' will display information for the third director listed)
        - Enter 'main' to return to the main menu
      end
      input = gets.strip.downcase
      if input == "main"
      elsif input.to_i > 0 && input.to_i <= ((Director.all.length/100.to_f).ceil)
        print_directors(input)
        puts ""
        puts "You are viewing page #{input} of directors."
      elsif /^info\s\d*$/.match(input)
        view_dir_info?(input)
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end
  
  def print_directors(input)
    Director.all.each_with_index do |dir, index|
      if index >= (input.to_i - 1)*100 && index < (input.to_i)*100
        puts "#{index + 1}) #{dir.name}"
      end
    end
  end
  
  def view_dir_info?(input)
    num = input.gsub("info", "")
    if num.to_i > 0 && num.to_i <= Director.all.length
      dir_info(num.to_i - 1)
    else 
      puts invalid = <<~end
    
      Invalid selection
      end
    end
  end
  
  def dir_info(input)
    dir = Director.all[input]
    
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

### Lists Country Path
  def list_countries
    input = 1
    puts ""
    print_countries
    while input != "main"
      puts countries = <<~end
      
        Country List Menu
        - Enter 'list' to reprint the list of countries
        - Enter 'info #' for more information on a specific country
            (Ex. 'info 8' will display information for the eighth country listed)
        - Enter 'main' to return to the main menu
      end
      input = gets.strip.downcase
      if input == "main"
      elsif input == "list"
        print_countries
      elsif /^info\s\d*$/.match(input)
        puts ""
        view_cty_info?(input)
      else
        puts invalid = <<~end
          
          Invalid selection
        end
      end
    end
  end
        
  def print_countries
    Country.all.each_with_index do |cty, index|
      puts "#{index + 1}) #{cty.name}"
    end
  end
  
  def view_cty_info?(input)
    num = input.gsub("info", "")
    if num.to_i > 0 && num.to_i <= Country.all.length
      cty_info(num.to_i - 1)
    else 
      puts invalid = <<~end
    
      Invalid selection
      end
    end
  end
  
  def cty_info(input)
    cty = Country.all[input]
    puts ""
    puts "#{cty.name} Criterion Profile"
    puts "- - - - - - - - - - - - - - - - - "
    puts "A total of #{cty.movies.length} films have been produced in #{cty.name}:"
    puts ""
    country_info_mov_list(cty)
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
      
### Lists Decade Path
  def list_years
    input = nil
    while input != "menu"
      puts decade = <<~end
      
        Decade List Menu
        - To browse titles by decade, enter a decade between '1920' and '#{Date.today.year}'
        - For more information on a title, enter 'view'
        - To return to the previous menu, enter 'menu'
      end
      input = gets.strip.downcase
      if input.to_i >= 1900 && input.to_i <= Date.today.year
        decade = input.to_i / 10 * 10
        counter = 0
        Movie.all.each_with_index do |mov, index|
          if mov.year.to_i >= decade && mov.year.to_i < (decade + 10)
            puts "#{index + 1}) #{mov.title} (#{mov.year})"
            counter += 1
          end
        end
        puts ""
        puts "A total of #{counter} Criterion films were made during the #{decade}s"
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
end