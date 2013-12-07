class AddSoundcloudidColumnToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :soundcloudid, :string
  end
end
