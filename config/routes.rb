Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users do
    member do
      get 'followings'
      get 'followers'
      get 'likes'
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts do
    resources :likes, only: [:create]
  end
  resources :relationships, only: [:create, :destroy]
  # resources :likes, only: [:create]
  # '/micropost/:id/likes'
end
