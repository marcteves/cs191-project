# LICENSE
# This is a course requirement for CS 192 Software Engineering II under the 
# supervision of Asst. Prof. Ma. Rowena C. Solamo of the Department of Computer 
# Science, College of Engineering, University of the Philippines, Diliman for the 
# AY 2018-2019
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
# Purpose of the software: To create a crowdsourced courier service for the 
# UP Community
Rails.application.routes.draw do
  root		'sessions#new'
  get 		'/home',		      to:	'users#home' # user homepage
  get 		'/my_requests',   to: 'users#my_requests' # user accepted requests
  post		'/accept',		    to: 'users#accept_request' # accept a request
  post		'/cancel',		    to: 'users#cancel_request' # cancel a request
  get		  '/user/:id',	    to: 'users#view',	as: "user_view" # view user
  get		  '/users',		      to:	'users#index' # view all users as admin
  post		'/verify',		    to: 'users#verify' # toggle verify status
  get		  '/user/:id/edit',	to:	'users#view_edit', as: 'user_view_edit' # view form for editing
  patch		'/user/:id',	    to: 'users#edit', as: 'user_edit' # edit user with params


  resources :requests

  get 		'/login', 	to: 'sessions#new'
  post 		'/login', 	to: 'sessions#create'
  delete 	'/logout', 	to: 'sessions#destroy'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
end
