Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home/show'
  get 'calendars/show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resource :calendars, only: [:show]
  resources :events do
    resources :tasks do
      get :update
    end
    get 'reports/:id/download', to: 'reports#download', as: 'download'
    resources :reports
  end 

  root to: "home#show"

end
