class MusicLibraryController

  extend Concerns::Findable

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    unless input == "exit"
      puts "What would you like to do?"
      self.call
    end
  end

  def list_songs
    songs_sorted_by_name = Song.all.sort {|a, b| a.name <=> b.name}
    songs_sorted_by_name.each_with_index do |item, index|
      puts "#{index + 1}." + " #{item.artist.name} - " + "#{item.name} -" + " #{item.genre.name}"
    end
  end

  def list_artists
    artists_sorted_by_name = Artist.all.sort {|a, b| a.name <=> b.name}
    artists_sorted_by_name.each_with_index do |item, index|
      puts "#{index + 1}." + " #{item.name}"
    end
  end

  def list_genres
    genres_sorted_by_name = Genre.all.sort {|a, b| a.name <=> b.name}
    genres_sorted_by_name.each_with_index do |item, index|
      puts "#{index + 1}." + " #{item.name}"
    end
  end

  # def list_songs_by_artist
  #   artist_list_array = []
  #   puts "Please enter the name of an artist:"
  #   artist = gets.chomp
  #   if artist != nil
  #       Artist.all.each_with_index do |artist_instance, index| artist_list_array << artist_instance.name
  #         puts "#{index + 1}." + " #{artist_list_array[index]}"
  #       end
  #   else
  #       puts "Please enter the name of an artist:"
  #       artist = gets.chomp
  #   end
  # end

  def list_songs_by_artist
      puts "Please enter the name of an artist:"
      artist_name_entered = gets.chomp
      the_artist = Artist.find_by_name(artist_name_entered)
      unless the_artist == nil
      sorted_songs = the_artist.songs.sort {|a, b| a.name <=> b.name}
      sorted_songs.each_with_index do |song, index|
        puts "#{index + 1}. " + "#{song.name} -" + " #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name_entered = gets.chomp
    unless genre_name_entered == nil
    the_genre = Genre.find_by_name(genre_name_entered)
    sorted_genre_songs = the_genre.songs.sort {|a, b| a.name <=> b.name}
    # binding.pry
    sorted_genre_songs.each_with_index do |song, index|
      puts "#{index + 1}. " + "#{song.artist} -" + " #{song.name}"
    end
  end
end




end