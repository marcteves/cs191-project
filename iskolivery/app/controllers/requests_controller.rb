class RequestsController < ApplicationController
  def view
  end

  def create
	  user = @current_user
	  location = Location.find_by(params[:location])

	  request = Request.create(
		  title: params[:title],
		  location_id: location.id,
		  item_name: params[:item_name]
	  )

	  user.postings.create(request_id: request.id)
	  redirect_to 'home'
  end
end
