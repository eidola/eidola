class Artist < ActiveRecord::Base
  attr_accessible :description, :image, :name, :soundcloudid
  validates  :name, presence: true, uniqueness: true
  has_many :artist_releases
  has_many :releases, :through => :artist_releases
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "150x150#" },
    :path => ":rails_root/public/artists/:id/:attachment/:style/:filename",
    :url => "/artists/:id/:attachment/:style/:filename"
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
