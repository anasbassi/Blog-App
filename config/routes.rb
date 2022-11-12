Rails.application.routes.draw do
  devise_for :users

  post 'authenticate', to: 'authentication#authenticate'
  namespace :api do
    resources :users do 
      resources :posts 
    end 
    resources :posts do
       resources :comments 
       resources :likes 
    end
  end
  root "users#index"
  
  resources :users, only: [:index, :show] do
    resources :posts, except: [:update, :edit] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
