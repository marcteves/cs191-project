class AddRequestStatusIdToAssignments < ActiveRecord::Migration[5.1]
  def change
    add_reference :assignments, :request_status, foreign_key: true
  end
end
