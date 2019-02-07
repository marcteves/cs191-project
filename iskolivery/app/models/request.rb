class Request < ApplicationRecord
	has_one :assignment

	validates :title, presence: true
	validates :location_id, presence: true
	# validates :deadline, presence: true
	validates :item_name, presence: true
	validates :bounty, presence: true
end
