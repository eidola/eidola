class CreateArtistsReleasesJoin < ActiveRecord::Migration
  def up
    create_table :artists_releases, :id => false do |t|
      t.integer :artist_id
      t.integer :release_id
    end
  end
  def down
    drop_table :artists_releases
  end
end
