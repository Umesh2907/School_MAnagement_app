Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  resources :schools do
    resources :students
    resources :teachers
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
