class RequestStatus < ApplicationRecord
	has_many :assignments
	validates :description, presence: true
end
