class AddBountyToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :bounty, :float, default: 0
  end
end
