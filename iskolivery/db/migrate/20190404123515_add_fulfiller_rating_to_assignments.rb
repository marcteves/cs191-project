class AddFulfillerRatingToAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :fulfiller_rating, :float
  end
end
