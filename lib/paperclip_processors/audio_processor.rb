module Paperclip
  class AudioProcessor < Processor
    
    def initialize(file, options = {}, attachment = nil)
      super
      @file = file
      @i = File.extname(@file.path).gsub('.','')
      @o = options[:format]
      @basename = File.basename(@file.path, File.extname(@file.path))
    end
    
    def make
      dst = Tempfile.new([@basename,".#{@o}"])
      if @i == "mp3" && @o == "ogg"
        cmd = " -i \"#{File.expand_path(@file.path)}\" -acodec libvorbis -ac 2 \"#{File.expand_path(dst.path)}\""
      elsif @i == "wav" && @o == "ogg"
        cmd = " -i \"#{File.expand_path(@file.path)}\" -acodec libvorbis \"#{File.expand_path(dst.path)}\""   
      elsif @i == "wav" && @o == "mp3"
        cmd = " -i \"#{File.expand_path(@file.path)}\" -acodec libmp3lame \"#{File.expand_path(dst.path)}\""
      end
      dst.binmode
      begin
        success = Paperclip.run("ffmpeg", cmd)
      rescue
        raise "conversion failed."
      end
      dst
      
    end
  end
end
