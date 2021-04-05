class MusicImporter
    attr_accessor :path, :song, :artist, :genre, :musiclibrarycontroller

    def initialize(path)
        @path = path
    end

    def files
        Dir.entries(@path).select! {|entry| entry.end_with?(".mp3")}
    end

    def import
        files_new = self.files
        files_new.each do |file|
            new_song = Song.create_from_filename(file)
        end
    end
end