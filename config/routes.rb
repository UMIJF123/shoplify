Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :checkout, only: %i[create]
  resources :webhooks, only: %i[create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
