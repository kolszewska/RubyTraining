Rails.application.routes.draw do
  root 'html_pages#home'
  get '/help', to: 'html_pages#help'
  get '/about', to: 'html_pages#about'
  get '/contact', to: 'html_pages#contact'
  get '/home', to: 'html_pages#home'
  get 'signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :feedbacks, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :users
end
