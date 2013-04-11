class Release < ActiveRecord::Base
  has_many :artist_releases
  has_many :artists, :through => :artist_releases
  attr_accessible :cover_url, :description, :title, :artist_name, :cover
  has_attached_file :cover, :styles => { :medium => "300x300", :thumb => "100x100" }, :default_url => "/public/releases/:id/cover.png"
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
