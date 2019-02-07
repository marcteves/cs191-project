class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.integer :requester
      t.integer :fulfiller
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
