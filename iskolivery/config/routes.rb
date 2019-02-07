Rails.application.routes.draw do
  root		'sessions#new'
  get 		'/home',		to:	'users#home' # user homepage
  get 		'/my_requests', to: 'users#my_requests' # user accepted requests
  post		'/accept',		to: 'users#accept_request' # accept a request

  resources :requests

  get 		'/login', 	to: 'sessions#new'
  post 		'/login', 	to: 'sessions#create'
  delete 	'/logout', 	to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
