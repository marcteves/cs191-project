# LICENSE
# This is a course requirement for CS 192 Software Engineering II under the
# supervision of Asst. Prof. Ma. Rowena C. Solamo of the Department of Computer
# Science, College of Engineering, University of the Philippines, Diliman for
# the AY 2018-2019
#
# This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
# International License.
#
# Author: Marc Teves
#
# CODE HISTORY
#
# INFORMATION
# File creation: February 5, 2019
# Development group: Group 1 - Iskolivery
# Client group: None
# Purpose of the software: To create a crowdsourced courier service for
# the UP Community
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
	validates :password, presence: true, length: { minimum: 8 }, on: :create
	validates :name, presence: true

	attribute :rating, default: 4.50

	has_secure_password

	def User.digest(password)
		BCrypt::Password.create(password)
	end
end
