Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'users#index'
  	
  resources :users, except: [:show, :new]
  resources :workcenters, except: [:show, :new]

	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/upload', to: 'uploads#show'
  post '/upload', to: 'uploads#create'

  get '/schedule/:workcenter', to: 'jobs#index', as: 'schedule'
  get '/schedule', to: 'jobs#index', as: 'schedules'
  patch '/schedule/:workcenter', to: 'jobs#move'
  patch '/schedule', to: 'jobs#move'

  get '/settings', to: 'settings#edit'
  patch '/settings', to: 'settings#update'

end
