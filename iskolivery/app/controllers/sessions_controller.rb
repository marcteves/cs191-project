class SessionsController < ApplicationController
  def new
  end

  def create
	  user = User.find_by(email: user_params[:email])
	  if user && user.authenticate(user_params[:password])
		  # Log-in
		  log_in user # find this in SessionsHelper
		  redirect_to '/home'
	  else
		  # Invalid info
		  # TODO: create error
		  redirect_to login_path
	  end
  end

  def destroy
	  if logged_in?
		  log_out user
	  end
  end

  private

	def user_params
		params.require(:session).permit(:email, :password)
	end

end
