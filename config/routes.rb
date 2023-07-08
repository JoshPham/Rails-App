Rails.application.routes.draw do
  resources :posts
  root "home#index"
  get "home/about", as: :about
end
