Rails.application.routes.draw do
  resources :machines do
    member do
      get 'play'
      get 'stop'
    end
  end
  root to: 'home#index'
end