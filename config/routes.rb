Rails.application.routes.draw do
  resources :machines
  root to: 'home#index'
end
