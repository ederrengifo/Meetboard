Rails.application.routes.draw do
  root "home#index"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  resources :sessions, except: [:edit]
end
