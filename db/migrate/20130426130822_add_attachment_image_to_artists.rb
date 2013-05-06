class AddAttachmentImageToArtists < ActiveRecord::Migration
  def self.up
    change_table :artists do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :artists, :image
  end
end
