Rails.application.routes.draw do
  devise_for :users
  resource :map, only: [:show]
  root to: 'homes#top'
  get 'top', to: 'homes#top', as: 'top'
  resources :users, only: [:show] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :favorites
      get :followings
      get :followers
    end
  end

  resources :post_images, only: [:new, :create, :index, :show, :destroy, :update, :edit ] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  #admin用のルートを追加
  devise_for :admins, path: 'administrator', controllers: {
    sessions: 'administrator/admins/sessions'
  }

  # ゲストログイン用のルートを追加
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :administrator do
    root 'users#index'
    resources :users, only: [:index, :show, :destroy]
    resources :post_images, only: [:index, :destroy]
    resources :post_comments, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
