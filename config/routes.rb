Cellove::Application.routes.draw do
  if Rails.env.development? || Rails.env.test?
    mount MailPreview => 'mail_view'
  end

  authenticated :user do
    root :to => 'dashboard#show'
  end
  root :to => "home#index"

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'user_registrations',
    passwords: 'passwords'
  } do
      post 'users/recover', to: 'user_registrations#recover', as: :recover_user_registration
  end

  devise_for :matchmakers, class_name: "User", controllers: {
    sessions: 'sessions',
    registrations: 'matchmaker_registrations'
  }

  resource :profile, only: [:show, :update]
  resources :notes, only: [:create, :destroy]

  resources :pictures, only: [:create, :destroy, :show, :update]
  resources :recommendations, only: [:index, :create] do
    post 'accept',       to: 'recommendations#accept'
    post 'deny',         to: 'recommendations#deny'
    post 'creator/toggle', to: 'recommendations#creator_toggle'
  end

  resources :users do
    post 'like',                    to: 'relationships#like'
    post 'unlike',                  to: 'relationships#unlike'
    post 'block_hide',              to: 'relationships#block_hide'
    post 'block_hide_settings',     to: 'relationships#block_hide_settings'

    get 'view',                     on: :collection
    get 'report',                   to: 'users#report'
  end

  get '/complete-fields', to: "dashboard#complete_fields", as: :complete_fields
  put '/update_complete_fields', to: "dashboard#update_complete_fields", as: :update_complete_fields
  get '/dashboard', to: "dashboard#show", as: :dashboard
  get '/dashboard/paginate', to: "dashboard#paginate_users", as: :dashboard_paginate

  scope "/user" do
    get 'settings',                 to: 'users#settings'

    get 'celestinos-i-want',        to: 'users#be_matchmaker',                    as: :be_matchmaker
    get 'celestino-become-user',    to: 'users#matchmaker_become_user',           as: :matchmaker_become_user
    get 'celestinos-of-mine',       to: 'users#my_matchmakers',                   as: :my_matchmakers
    get 'nice-couple',              to: 'users#nice_couple',                      as: :nice_couple

    get 'likes',                    to: 'users#likes',                            as: :user_likes
    get 'likes-of-mine',            to: 'users#likes_of_mine',                    as: :user_likes_of_mine
    get 'hits',                     to: 'users#hits',                             as: :user_hits

    get 'cellove-index',            to: 'users#cellove_index',                    as: :cellove_index
    get 'search',                   to: 'users#index',                            as: :search
    get 'pay',                      to: 'profiles#pay',                           as: :pay
    get 'pay/confirmation',         to: 'profiles#pay_confirmation',              as: :pay_confirmation

    put 'general_settings',         to: 'users#general_settings',                 as: :general_settings
  end
  post '/rate' => 'rater#create', :as => 'rate'
  post 'background',               to: 'users#save_background',                   as: :save_background
  get 'background',                to: 'users#get_background',                    as: :get_background

  #get 'aviso-legal' => 'flat_pages#legal', as: :legal
  get 'what' => 'flat_pages#what', as: :what
  get 'how-works' => 'flat_pages#how_it_works', as: :how_it_works
  get 'raise-popularity' => 'flat_pages#raise_popularity', as: :raise_popularity
  get 'matchmakers' => 'flat_pages#matchmakers', as: :matchmakers
  get 'terms-and-conditions' => 'flat_pages#terms_conditions', as: :terms_conditions
  get 'privacy-policy' => 'flat_pages#privacy_policy', as: :privacy_policy
  get 'usage' => 'flat_pages#usage', as: :usage
  get 'robots.txt' => 'flat_pages#robots'
  get 'contact-us' => 'flat_pages#new_contact_form', as: :new_contact_form
  post 'contact' => 'flat_pages#contact_form', as: :contact_form
  get 'media-press' => 'flat_pages#media_press', as: :media_press
  get 'error' => 'flat_pages#error', as: :error
  get 'tv-spot/:id' => 'flat_pages#tv_spot', as: :tv_spot

  resources :messages
  resources :conversations
  delete 'conversations', to: 'conversations#destroy_all', as: :destroy_all_conversations

  resources :activities, only: [:new, :create] do
    post 'reject'
  end

  get 'notifications',                 to: 'notifications#notifications',          as: :notifications
  resources :invitations
  resources :searches, only: [:create, :destroy, :show]

  get :cities, to: 'cities#index'
end
