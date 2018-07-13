Rails.application.routes.draw do


  root to: 'users#new'
  resources:blogs do
    collection do
      post :confirm
    end
  end
  get '/blogs', to: 'blogs#index'
  resources :users
  resources :sessions,only: [:new,:create,:destroy]
  resources :favorites,only: [:show,:create,:destroy]

end
