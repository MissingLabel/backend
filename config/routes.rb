Rails.application.routes.draw do

  post "login" => "sessions#create", :defaults => { :format => :json }
  delete "logout" => "sessions#destroy", :defaults => { :format => :json }

  get "items/:number" => "items#showzz", :defaults => { :format => :json }
  get "produce" => "produce#index"

  resources :users, only:[:create, :new, :destroy], :defaults => { :format => :json }

  # root 'items#json_object'
     root 'produce#index'
end
