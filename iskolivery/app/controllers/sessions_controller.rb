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
class SessionsController < ApplicationController
  def new
	  # prevent logged in user from having to log-in again
	  if logged_in?
		  redirect_to home_path
	  end
  end

  def create
	  user = User.find_by(email: user_params[:email])
	  if user && user.authenticate(user_params[:password])
		  # Log-in
		  log_in user # find this in SessionsHelper
		  redirect_to '/home'
	  else
		  valid_email_regex = /\A[\w+\-.]+@up\.edu\.ph\z/i
		  unless valid_email_regex =~ user_params[:email]
			  flash.now[:error] = "Invalid email field (must end with '@up.edu.ph'."
		  else
			  flash.now[:error] = "Invalid credentials."
		  end
		  render 'new'
	  end
  end

  def destroy
	  if logged_in?
		  log_out
		  redirect_to login_path
	  end
  end

  private

	def user_params
		params.require(:session).permit(:email, :password)
	end

end
