class News < ActiveRecord::Base
  attr_accessible :content, :date, :title, :image
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "200x200#" },
    :path => ":rails_root/public/news/:id/:attachment/:style/:filename",
    :url => "/news/:id/:attachment/:style/:filename"
end
