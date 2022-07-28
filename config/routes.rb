Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'users#index'
  resources :users do
    collection{ post :import }
  end
  
  resources :schools do
    collection{ post :import }
    resources :students 
    resources :teachers 
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
