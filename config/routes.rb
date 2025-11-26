Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "about" => "homes#about"
  resources :post_images, only: [:new, :create, :index, :show, :destroy, :update, :edit ] do
    resources :post_comments, only: [:create]
    resource :favorites, only: [:create, :destroy]
  end
  #admin用のルートを追加
  devise_for :admins, path: 'administrator', controllers: {
    sessions: 'administrator/admins/sessions'
  }

  namespace :administrator do
    root 'users#index'
    resources :users, only: [:index, :show, :destroy]
    resources :post_images, only: [:index, :destroy]
    resources :post_comments, only: [:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
