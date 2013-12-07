class CreateTracks < ActiveRecord::Migration
  def change

    create_table :tracks do |t|
      t.integer :release_id
      t.string :title
      t.integer :number

      t.timestamps
    end
  end
end
