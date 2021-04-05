class Song
    attr_accessor :name, :artist, :genre, :musicimporter, :musiclibrarycontroller
    extend Concerns::Findable
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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
        song = self.new(name)
        song.save
        song
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre
        @genre
    end

    def genre=(genre)
        @genre = genre
        self.genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        @@all.detect do |song|
            song.name == name
        end
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        file = filename.split(" - ")
        name_of_artist = file[0]
        name_of_song = file[1]
        name_of_genre = file[2].split(".mp3").join
        artist = Artist.find_or_create_by_name(name_of_artist)
        genre = Genre.find_or_create_by_name(name_of_genre)
        self.new(name_of_song, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end
end