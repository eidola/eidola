class Release < ActiveRecord::Base
  has_many :artist_releases
  has_many :artists, :through => :artist_releases
  has_many :tracks, :dependent => :destroy
  accepts_nested_attributes_for :tracks, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  attr_accessible :description, :title, :artist_name, :cover, :tracks_attributes, :zip
  has_attached_file :cover, :styles => { :medium => "300x300", :thumb => "200x200" }
  has_attached_file :zip

  def artist_name
    @a = ""
    artists.each do | artist|
       @a << artist.name << ", "
    end
    @a
  end
  def artist_name=(names)
    self.artists = names[0].split(',').map { |name| Artist.find_or_create_by_name(name.strip) }
  end
end
