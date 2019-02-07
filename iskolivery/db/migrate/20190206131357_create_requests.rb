class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :requester
      t.integer :fulfiller
      t.string :title
      t.integer :location
      t.datetime :deadline
      t.string :item_name

      t.timestamps
    end
  end
end
