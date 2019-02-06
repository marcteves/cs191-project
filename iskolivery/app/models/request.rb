class Request < ApplicationRecord
	belongs_to :requester, class_name: "User", foreign_key: "requester"
	belongs_to :fulfiller, class_name: "User", foreign_key: "fulfiller"

	validates :requester, presence: true
	validates :title, presence: true
	validates :location, presence: true
	validates :deadline, presence: true
	validates :item_name, presence: true

	
end
