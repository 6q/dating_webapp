Cellove::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  
  #get 'aviso-legal' => 'flat_pages#legal', as: :legal
  get 'que-es' => 'flat_pages#what', as: :what
  get 'terms-and-conditions' => 'flat_pages#terms_conditions', as: :terms_conditions
  get 'politica-de-privacidad' => 'flat_pages#privacy_policy', as: :privacy_policy
  get 'consejos-de-uso' => 'flat_pages#usage', as: :usage
  get 'robots.txt' => 'flat_pages#robots'
end
