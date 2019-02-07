class ChangeRequesterToRequesterIdInAssignment < ActiveRecord::Migration[5.1]
  def change
	  rename_column :assignments, :requester, :requester_id
	  change_column :assignments, :requester_id, :integer
  end
end
