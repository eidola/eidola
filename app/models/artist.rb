class Artist < ActiveRecord::Base
  attr_accessible :description, :image, :name
  has_many :artist_releases
  has_many :releases, :through => :artist_releases
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "200x200#" }
end
