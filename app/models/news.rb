class News < ActiveRecord::Base
  attr_accessible :content, :date, :title, :image
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "200x200#" }
end
