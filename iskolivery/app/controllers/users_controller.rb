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
class UsersController < ApplicationController

	# render User homepage
	def home
		@user = current_user
		
		@new_request = Request.new

		# get all requests not posted by and not accepted by user
		# keep in mind null values
		@available_requests = Assignment.where(fulfiller_id: nil)
			.or(Assignment.where.not(fulfiller_id: @user.id))
			.where.not(requester_id: @user.id)
	end

	# render accepted requests page
	# this could be posted requests page as well
	def my_requests
		user = current_user

		# get all requests accepted by user
		# in the future, edit this to filter out fulfilled (completed)
		@accepted_requests = user.accepteds
	end

	# accept a selected request in the homepage
	def accept_request
		user = current_user

		assignment = Assignment.find_by(request_id: params[:request_id])
		user.accepteds << assignment

		redirect_back fallback_location: '/home'
	end
end
