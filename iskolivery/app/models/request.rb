class Request < ApplicationRecord
	belongs_to :requester, class_name: "User", foreign_key: "requester"
	belongs_to :fulfiller, class_name: "User", foreign_key: "fulfiller"
	belongs_to :location, class_name: "Location", foreign_key: "location_id"

	validates :requester, presence: true
	validates :title, presence: true
	validates :location_id, presence: true
	# validates :deadline, presence: true
	validates :item_name, presence: true

	
end
