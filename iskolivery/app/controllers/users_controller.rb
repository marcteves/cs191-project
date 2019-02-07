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
