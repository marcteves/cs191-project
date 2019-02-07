class ChangeLocationToLocationId < ActiveRecord::Migration[5.1]
  def change
	  rename_column :requests, :location, :location_id
	  change_column :requests, :location_id, :integer
  end
end
