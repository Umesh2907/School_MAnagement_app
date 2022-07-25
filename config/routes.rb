Rails.application.routes.draw do
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
