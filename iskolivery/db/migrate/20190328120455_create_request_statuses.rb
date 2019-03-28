class CreateRequestStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :request_statuses do |t|
      t.string :description

      t.timestamps
    end
  end
end
