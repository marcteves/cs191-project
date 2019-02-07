class UsersController < ApplicationController

	# render User homepage
	def home
		user = @current_user 

		# get all requests not posted by and not accepted by user
		# keep in mind null values
		@available_requests = Requests.where(fulfiller: nil).
			or(Requests.where.not(fulfiller: user.id)).
			where.not(requester: user.id)
	end

	# render accepted requests page
	# this could be posted requests page as well
	def my_requests
		user = @current_user

		# get all requests accepted by user
		# in the future, edit this to filter out fulfilled (completed)
		@accepted_requests = Requests.where(fulfiller: user.id)
	end
end
