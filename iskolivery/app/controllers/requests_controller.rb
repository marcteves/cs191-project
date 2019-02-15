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
		params.require(:request).permit(:title, :location_id,
										:item_name, :bounty)
	end
end
