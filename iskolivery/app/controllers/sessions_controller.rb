class SessionsController < ApplicationController
  def new
  end

  def create
	  user = User.find_by(email: params[:email])
	  if user && user.authenticate(params[:password])
		  # Log-in
		  log_in user # find this in SessionsHelper
	  else
		  # Invalid info
		  # TODO: create error
		  redirect_to login_path
	  end
  end

  def destroy
  end

end
