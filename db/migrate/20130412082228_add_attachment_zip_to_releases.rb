class AddAttachmentZipToReleases < ActiveRecord::Migration
  def self.up
    change_table :releases do |t|
      t.attachment :zip
    end
  end

  def self.down
    drop_attached_file :releases, :zip
  end
end
