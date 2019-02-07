class RemoveRequesterFulfillerFromRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :requests, :requester, :string
    remove_column :requests, :fulfiller, :string
  end
end
