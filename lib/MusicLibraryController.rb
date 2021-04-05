class MusicLibraryController 

    def initialize(path = "./db/mp3s")
        @music_importer = MusicImporter.new(path)
        @music_importer.import
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
            case input
            when "list songs"
                list_songs
            when "list artists"
                list_artists
            when "list genres"
                list_genres
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            end
            until input == "exit"
                input = gets.strip
            end
        end

        def list_songs
            all_songs = Song.all
            all_songs.sort! {|song_1, song_2| song_1.name <=> song_2.name}
            Song.all.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
        end
        
        def list_artists
            all_artists = Artist.all
            all_artists.collect! {|artist| artist.name}.sort!
            all_artists.each_with_index {|artist, index| puts "#{index + 1}. " + artist}
        end

        def list_genres
            Genre.all.collect! {|genre| genre.name}.sort!
            Genre.all.each_with_index {|genre, index| puts "#{index + 1}. " + genre}
        end

        def list_songs_by_artist
            puts "Please enter the name of an artist:"
            name = gets.strip
            if artist = Artist.find_by_name(name)
                artist.songs.sort{|x, y| x.name <=> y.name}.each_with_index do |a, b|
                    puts "#{b + 1}. #{a.name} - #{a.genre.name}"
                end
            end
        end

        def list_songs_by_genre
            puts "Please enter the name of a genre:"
            name = gets.strip
            if genre = Genre.find_by_name(name)
                genre.songs.sort{|x, y| x.name <=> y.name}.each_with_index do |a, b|
                    puts "#{b + 1}. #{a.artist.name} - #{a.name}"
                end
            end
        end

        def play_song
            puts "Which song number would you like to play?"
            input = gets.strip
            index_selected = input.to_i - 1
            if index_selected.between?(0, Song.all.length - 1)
                song_selected = Song.all.sort {|a, b| a.name <=> b.name}[index_selected]
                puts "Playing #{song_selected.name} by #{song_selected.artist.name}"
            end
        end
end