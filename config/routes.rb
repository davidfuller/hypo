Rails.application.routes.draw do
  resources :machines do
    collection do
      get 'connect'
    end
  end
  root to: 'home#index'
end
