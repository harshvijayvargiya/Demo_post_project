# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  resources :msgs
  post '/rate' => 'rater#create', :as => 'rate'
  mount Sidekiq::Web => '/sidekiq'
  
  namespace :api, defaults: { format: :json } do
   resources :posts do
      collection do
        get :all_user_post
        get :download_file
        get :posts_by_status
        get :all_posts_by_status
        delete :destroy_multiple
      end
    end
  end

  resources :posts do
    resources :comments
    collection do
      get :all_user_post
      get :download_file
      get :posts_by_status
      get :all_posts_by_status
      delete :destroy_multiple
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  root 'welcome#index'
  match '*path' => 'errors#routing', via: :all
end
