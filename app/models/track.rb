class Track < ActiveRecord::Base
  belongs_to :release
  attr_accessible :number, :release_id, :title, :file
  has_attached_file :file
end
