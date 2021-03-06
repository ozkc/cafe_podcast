# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  resources :subscriptions, param: :slug, path: 'shows'
  get '/search' => 'pages#search', :as => 'search_page'
  get '/peek' => 'pages#peek'
  post '/peek' => 'pages#peek'
end
