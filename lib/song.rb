class Song
  
  attr_accessor :name, :artist, :genre, :musiclibrarycontroller, :musicimporter
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = (artist) if artist != nil
    self.genre = (genre) if genre != nil 
  end
  
  def self.all
    @@all
  end 
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    if genre.songs.none? {|song| song == self}
      genre.songs << self
    end
  end
  
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(file_name)
    array = file_name.split(" - ")
    song_name = array[1]
    artist_name = array[0]
    genre_name = array[2].split(".mp3").join
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(file_name)
    new_song = self.new_from_filename(file_name)
    new_song.save
  end
  
end