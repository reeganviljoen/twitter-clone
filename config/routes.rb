Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: %i[show edit update] do
    resources :follows, only: %i[create destroy]
  end

  resources :tweets , except: %i[edit update show] do
    resources :likes, only: %i[new create destroy]
    resources :comments, except: %i[edit update show]
    resources :retweets, only: %i[new create]
  end
  
  root "tweets#index"
end
