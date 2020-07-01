Rails.application.routes.draw do
  resources :clips
  resources :machines do
    member do
      get 'play'
      get 'stop'
      get 'list'
    end
  end
  root to: 'home#index'
end