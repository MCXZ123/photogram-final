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

  get "/feed", to: "photos#feed"
  get "/discover", to: "photos#discover"
end
