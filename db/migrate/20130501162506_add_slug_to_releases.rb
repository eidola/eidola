class AddSlugToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :slug, :string
  end
end
