class ChangeFulfillerToFulfillerIdInAssignment < ActiveRecord::Migration[5.1]
  def change
	  rename_column :assignments, :fulfiller, :fulfiller_id
	  change_column :assignments, :fulfiller_id, :integer
  end
end
