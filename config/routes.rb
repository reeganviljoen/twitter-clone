Rails.application.routes.draw do
  devise_for :users

  resources :tweets , except: [:edit, :update, :show] do
    resources :likes, only: [:new, :create, :destroy]
  end

  root "tweets#index"
end
