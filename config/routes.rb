Rails.application.routes.draw do
  devise_for :users

  resources :tweets , except: [:edit, :update] do
    resources :likes, only: [:new, :create, :destroy]
    resources :comments, except: [:edit, :update]
    resources :retweets, only: [:new, :create, :show]
  end

  root "tweets#index"
end
