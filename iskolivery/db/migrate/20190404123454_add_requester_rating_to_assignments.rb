class AddRequesterRatingToAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :requester_rating, :float
  end
end
