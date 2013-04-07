class Release < ActiveRecord::Base
  attr_accessible :cover_url, :description, :title
  has_many :artists
end
