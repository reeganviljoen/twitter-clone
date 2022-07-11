Rails.application.routes.draw do
  devise_for :users

  resources :tweets , except: [:edit, :update, :show]

  root "tweets#index"
end
