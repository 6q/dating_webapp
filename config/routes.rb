Cellove::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  
  #get 'aviso-legal' => 'flat_pages#legal', as: :legal
  get 'que-es' => 'flat_pages#what', as: :what
  get 'como-funciona' => 'flat_pages#how_it_works', as: :how_it_works
  get 'consigue-popularidad' => 'flat_pages#raise_popularity', as: :raise_popularity
  get 'celestinos' => 'flat_pages#matchmakers', as: :matchmakers
  get 'terms-and-conditions' => 'flat_pages#terms_conditions', as: :terms_conditions
  get 'politica-de-privacidad' => 'flat_pages#privacy_policy', as: :privacy_policy
  get 'consejos-de-uso' => 'flat_pages#usage', as: :usage
  get 'robots.txt' => 'flat_pages#robots'
  get 'contacta' => 'flat_pages#new_contact_form', as: :new_contact_form
  post 'contact' => 'flat_pages#contact_form', as: :contact_form
  get 'media-prensa' => 'flat_pages#media_press', as: :media_press
  get 'anuncio-tv/:id' => 'flat_pages#tv_spot', as: :tv_spot
end
