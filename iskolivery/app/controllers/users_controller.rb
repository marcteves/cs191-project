class UsersController < ApplicationController

	# render User homepage
	def home
		@user = @current_user 

		# show all requests not posted by and not accepted by user
		# keep in mind null values
		@available_requests = Requests.where(fulfiller: nil).
			or(Requests.where.not(fulfiller: @user.id)).
			where.not(requester: @user.id)
	end
end
