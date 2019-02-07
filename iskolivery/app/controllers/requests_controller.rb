class RequestsController < ApplicationController
  def view
  end

  def create
	  user = current_user
	  location = Location.find_by(request_params[:location_id])

	  request = Request.create!(
		  title: request_params[:title],
		  location_id: location.id,
		  item_name: request_params[:item_name],
		  bounty: request_params[:bounty]
	  )

	  user.postings.create!(request_id: request.id)
	  redirect_back fallback_location: '/home'
  end

  private

	def request_params
		params.require(:request).permit(:title, :location_id, :item_name,
									   :bounty)
	end
end
