class Track < ActiveRecord::Base
  belongs_to :release
  attr_accessible :number, :release_id, :title, :file
  has_attached_file :file,
  :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  :url => "/system/:attachment/:id/:style/:filename",
  :processors => [:audio_processor],  
  :styles => {
    :ogg => {
      :format => "ogg"
    },
    :mp3 => {
      :format => "mp3"
    }
  }
end
