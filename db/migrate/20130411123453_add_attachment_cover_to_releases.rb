class AddAttachmentCoverToReleases < ActiveRecord::Migration
  def self.up
    change_table :releases do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :releases, :cover
  end
end
