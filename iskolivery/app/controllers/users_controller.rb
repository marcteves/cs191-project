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

	# only give @users if admin, otherwise give 403 Forbidden
	def index
		if user = check_admin
			@users = User.all
		else
			redirect_to '/public/422.html', status: 422
		end
	end

	# render User homepage
	def home
		@user = current_user

		@new_request = Request.new

		# get all requests not posted by and not accepted by user
		# keep in mind null values
		@available_requests = Assignment.where(fulfiller_id: nil)
			.or(Assignment.where.not(fulfiller_id: @user.id))
			.where.not(requester_id: @user.id)

		@accepted_requests = @user.accepteds

		# active requests are the requests posted by user
		# which have status accepted (1)
		@active_requests = Assignment.where(requester_id: @user.id)
			.where('request_status_id = 1')

		# pending requests are requests posted by user
		# which have status pending (0)
		@pending_requests = Assignment.where(requester_id: @user.id)
			.where('request_status_id = 0')
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
		assignment.update(request_status_id: 1) # status: accepted

		redirect_back fallback_location: '/home'
	end

	# cancel selected request in the my accepted requests page
	def cancel_request
		user = current_user

		assignment = Assignment.find_by(request_id: params[:request_id])
		user.accepteds.delete(assignment)
		assignment.update(request_status_id: 3) # status: cancelled

		redirect_back fallback_location: '/home'
	end

	# toggle verify status of user
	def verify
		if user = check_admin
			target_user = User.find_by(id: params[:user_id])
			target_user.toggle!(:verified)
			redirect_back fallback_location: '/home'
		end
	end

	# toggle enabled status of user
	def disable
		if user = check_admin
			target_user = User.find_by(id: params[:id])
			target_user.toggle!(:enabled)
			redirect_back fallback_location: '/home'
		end
	end

	# view user by id
	def view
		request_user(params[:id])
	end

	# view user and show edit form
	def view_edit
		request_user(params[:id])
		target_user = @user
		if current_user.id != target_user.id && @admin == false
			redirect_to '/public/422.html', status: 422
			return false
		end
	end

	# user edit
	def edit
		request_user(params[:id])
		target_user = @user
		if current_user.id != target_user.id && @admin == false
			redirect_to '/public/422.html', status: 422
			return false
		end

		request_params.each do |key, value|
			target_user[key] = value
		end
		target_user.save

		redirect_to home_path
	end

	private
		def check_admin
			user = current_user

			if !current_user.admin?
				return false
			end

			return user
		end

		# allow access to user if it's the same user, or if it's an admin
		# set @admin to true if user requesting access is an admin
		# return false when user should not have access / user not found
		def request_user(id)
			@admin = false
			if check_admin
				@admin = true
			end

			begin
				@user = User.find(params[:id])
			rescue ActiveRecord::RecordNotFound
				redirect_to '/public/404.html', status: 404
				return false
			end
		end

		def request_params
			params.require(:user).permit(:name, :enabled)
		end
end
