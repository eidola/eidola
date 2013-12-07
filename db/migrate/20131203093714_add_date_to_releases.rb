class AddDateToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :date, :date
  end
end
