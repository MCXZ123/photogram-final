Rails.application.routes.draw do
  root "home#index"

  resources :photos
  resources :comments
  resources :likes
  resources :follow_requests do
    member do
      post :accept
      post :reject
    end
  end

  devise_for :users, controllers: {
    sessions: "users/sessions"
  }

  resources :users, only: [:index, :show]

  # 🔽 Add these routes for user-specific pages
  get "/users/:username/feed", to: "users#feed", as: :user_feed
  get "/users/:username/liked_photos", to: "users#liked_photos", as: :user_liked_photos
  get "/users/:username/discover", to: "users#discover", as: :user_discover

  # 🔽 Keep this last, so it doesn't override more specific paths
  get "/users/:username", to: "users#show", as: :user_profile
end
