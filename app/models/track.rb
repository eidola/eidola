class Track < ActiveRecord::Base
  belongs_to :release
  attr_accessible :number, :release_id, :title, :file
  has_attached_file :file,
  :path => ":rails_root/public/tracks/:id/:attachment/:style/:filename",
  :url => "/tracks/:id/:attachment/:style/:filename",
  :processors => [:audio_processor],  
  :styles => {
    :ogg => {
      :format => "ogg"
    },
    :mp3 => {
      :format => "mp3"
    }
  }
  validates_attachment_content_type :file, :content_type => "audio/wav"
end
