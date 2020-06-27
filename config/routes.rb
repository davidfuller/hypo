Rails.application.routes.draw do
  resources :machines do
    member do
      get 'connect'
      get 'close'
    end
  end
  root to: 'home#index'
end