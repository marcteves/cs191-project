class Assignment < ApplicationRecord
	belongs_to :requester, class_name: "User", foreign_key: "requester_id"
	
	belongs_to :fulfiller, class_name: "User", foreign_key: "fulfiller_id",
		optional: true # since we can choose not to include this
	belongs_to :request

	# Only validate requester
	# fulfiller can be null at creation time
	validates :requester_id, presence: true
end
