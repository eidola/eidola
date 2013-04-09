class Artist < ActiveRecord::Base
  attr_accessible :description, :image_url, :name
  has_many :artist_releases
  has_many :releases, :through => :artist_releases
end
