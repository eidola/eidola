require 'taglib'
class Release < ActiveRecord::Base
  has_many :artist_releases
  has_many :artists, :through => :artist_releases
  has_many :tracks, :dependent => :destroy
  accepts_nested_attributes_for :tracks, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  attr_accessible :description, :title, :artist_name, :cover, :tracks_attributes, :zip, :date
  validates :title, :description, :artist_name, presence: true
  has_attached_file :cover, :styles => { :medium => "300x300#", :thumb => "200x200#" },
  :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  :url => "/system/:attachment/:id/:style/:filename"
  has_attached_file :zip,
  :path => ":rails_root/public/system/releases/:id/:style/:filename",
  :url => "/system/releases/:id/:style/:filename",
  :processors => [:zip_processor],
  :styles => {
    :ogg => {
      :audio => "ogg"
    },
    :mp3 => {
      :audio => "mp3"
    }
  }
  

  #after_save :create_zips
  before_save :convert_tracks, :add_default_zip

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def formats
    ["mp3","ogg"]
  end

  def convert_tracks
    if self.tracks.count > 0
      self.tracks.each do |track|
        formats.each do |format|
          @file = track.file.path(format)
          TagLib::FileRef.open(@file) do |fileref|
            unless fileref.null?
              tag = fileref.tag
              tag.title = track.title
              tag.artist = self.artist_name
              tag.album = self.title
              tag.track = track.number
              tag.comment = "Eidola Records"
              tag.year = self.date.year
              fileref.save
            end
          end
        end
      end
    end
  end

  def add_default_zip
    if self.tracks.count > 0
      @file_name = "#{self.title}"
      t = Tempfile.new([@file_name, '.zip'])
      Zip::ZipOutputStream.open(t.path) do |z|
        self.tracks.each do |track|
          title = File.basename(track.file.path)
          z.put_next_entry(title)
          z.print IO.read(track.file.path)
        end
        if !self.cover.blank?
          extension = File.extname(self.cover.path).downcase
          cover = "cover#{extension}"
          z.put_next_entry(cover)
          dest = Tempfile.new(self.cover.original_filename)
          self.cover.copy_to_local_file('original', dest.path)
          z.print IO.read(dest)
        end
      end
      t.close
      
      File.open(t.path) do |file|
        self.zip = file
        self.zip_file_name = "#{@file_name}.zip"
      end
    end
  end

  def create_zip (format)
    @style = format
    @path = "#{::Rails.root}/public/system/zips/#{self.id}/#{@style}/"
    puts @path
    if self.tracks.count >0
      file_name = "#{self.title}"
      t = Tempfile.new([file_name,'.zip'])
      Zip::ZipOutputStream.open(t.path) do |z|
        self.tracks.each do |track|
          title = File.basename(track.file.path(format))
          z.put_next_entry(title)
          puts track.file.path(format)
          z.print IO.read(track.file.path(format))
        end
        if !self.cover.blank?
          extension = File.extname(self.cover.path).downcase
          cover = "cover#{extension}"
          z.put_next_entry(cover)
          dest = Tempfile.new(self.cover.original_filename)
          self.cover.copy_to_local_file('original', dest.path)
          z.print IO.read(dest)
        end
      end
      @file_path = "#{@path}#{file_name}.zip"
      FileUtils.mkdir_p(File.dirname(@file_path))
      FileUtils.cp(t.path, @file_path)
      t.close
    end        
  end

  def artist_name
    @a = ""
    artists.each do | artist|
      if @a != '' then @a << "," end
      @a << artist.name
    end
    @a
  end
  def artist_name=(names)
    self.artists = names[0].split(',').map { |name| Artist.find_or_create_by_name(name.strip) }
  end
end
