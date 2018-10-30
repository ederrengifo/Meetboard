Rails.application.routes.draw do

  get 'home/show'
  get 'calendars/show'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'events/index', to: 'events#index', as: 'logged'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resource :calendars, only: [:show]
  resources :events, only: [:index, :show, :update]

  root to: "home#show"

end
