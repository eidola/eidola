class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :title
      t.text :description
      t.string :cover_url

      t.timestamps
    end
  end
end
