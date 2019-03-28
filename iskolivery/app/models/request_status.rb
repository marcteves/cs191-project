class RequestStatus < ApplicationRecord
	validates :description, presence: true
end
