Rails.application.routes.draw do

  # get "login" => "sessions#new"
  post "login" => "sessions#create", :defaults => { :format => :json }
  delete "logout" => "sessions#destroy", :defaults => { :format => :json }

  resources :items, only: [:show], :defaults => { :format => :json }
  get "produce" => "produce#index"

  resources :users, only:[:create, :new, :destroy], :defaults => { :format => :json }
  root 'produce#index'
end
