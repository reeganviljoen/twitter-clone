Rails.application.routes.draw do
  devise_for :users

  resources :tweets , except: [:edit, :update, :show] do
    resources :likes, only: [:new, :create, :destroy]
    resources :comments, except: [:edit, :update, :show]
    resources :retweets, only: [:new, :create]
  end

  resources :users, only: :show

  root "tweets#index"
end
