Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users

  resources :photos
  resources :comments
  resources :likes

  resources :follow_requests do
    member do
      post :accept
      post :reject
    end
  end

  resources :users, only: [:index, :show]

  # Defines the root path route ("/")
  # root "photos#index"

  get "/feed", to: "photos#feed", as: :feed
  get "/discover", to: "photos#discover", as: :discover
end
