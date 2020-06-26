Rails.application.routes.draw do
  resources :machines do
    member do
      get 'connect'
    end
  end
  root to: 'home#index'
end