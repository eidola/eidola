module Paperclip
  class ZipProcessor < Processor
    
    def initialize(file, options = {}, attachment = nil)
      super
      @file = file
      @format = options[:audio]
      @instance = attachment.instance
      @tracks = @instance.tracks
      @cover = @instance.cover
      @title = @instance.title
    end
    
    def make
      t = Tempfile.new([@title, '.zip'])
      Zip::ZipOutputStream.open(t.path) do |z|
        @tracks.each do |track|
          puts track.title
          z.put_next_entry("#{track.title}.#{@format}")
          z.print IO.read(track.file.path(@format))
        end
        
        if !@cover.blank?
          extension = File.extname(@cover.path).downcase
          cover = "cover#{extension}"
          z.put_next_entry(cover)
          dest = Tempfile.new(cover)
          @cover.copy_to_local_file('original', dest.path)
          z.print IO.read(dest)
        end          
      end
      puts "[ZIP CREATED] Format: %s, Path: %s" % [@format, t.path]
      t
    end
  end
end    
