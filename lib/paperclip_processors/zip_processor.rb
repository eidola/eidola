module Paperclip
  class ZipProcessor < Processor
    
    super
    def initialize(file, options = {}, attachment = nil)
      puts '[Zip Processor] %s' % self.tracks.count
    end
    
    def make
    end
  end
end    
