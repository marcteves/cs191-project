Rails.application.routes.draw do
  get 'requests/view'

  get 		'login', 	to: 'sessions#new'
  post 		'login', 	to: 'sessions#create'
  delete 	'login', 	to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
