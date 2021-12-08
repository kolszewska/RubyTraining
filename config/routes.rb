Rails.application.routes.draw do
  root 'html_pages#home'
  get 'html_pages/help'
  get 'html_pages/about'
  resources :feedbacks
  resources :users
end
