Rails.application.routes.draw do

  resources :categories
  resources :enrollments
  devise_for :users
  resources :users
  resources :courses do
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end
  get 'home/index', as: 'home'
  get 'static/index'
  # root 'courses#index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
