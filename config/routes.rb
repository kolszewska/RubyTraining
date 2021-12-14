Rails.application.routes.draw do
  root 'html_pages#home'
  get 'html_pages/help'
  get 'html_pages/about'
  get 'html_pages/contact'
  get 'html_pages/home'
  resources :feedbacks
  resources :users
end
