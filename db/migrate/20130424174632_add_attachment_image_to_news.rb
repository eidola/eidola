class AddAttachmentImageToNews < ActiveRecord::Migration
  def self.up
    change_table :news do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :news, :image
  end
end
