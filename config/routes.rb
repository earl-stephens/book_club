Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/books', to: 'books#index'
  resources :reviews
  #get '/reviews/new', to: 'reviews#new'
  #get '/reviews/id', to: 'reviews#id'
end
