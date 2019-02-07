class User < ApplicationRecord

	# associations to Assignment, used by associations below
	has_many :postings, 	class_name: "Assignment",
							foreign_key: "requester_id"
	has_many :accepteds, 	class_name: "Assignment",
							foreign_key: "fulfiller_id"

	# these associations allow a User to access posted and accepted 
	# requests directly using User.<association>
	has_many :posted_requests,		through: :postings, source: :request
	has_many :accepted_requests,	through: :accepteds, source: :request

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX }
		# uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 8 }

	has_secure_password
end
