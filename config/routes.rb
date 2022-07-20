Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: :show
  resources :tweets , except: [:edit, :update, :show] do
    resources :likes, only: [:new, :create, :destroy]
    resources :comments, except: [:edit, :update, :show]
    resources :retweets, only: [:new, :create]
  end
  
  root "tweets#index"
end
