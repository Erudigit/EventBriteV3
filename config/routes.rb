Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'events#index'
  resources :events, only: [:index, :new, :create, :show]
  resources :users
  resources :charges
  resources :attendances, only: [:index, :create]
  get '/attendances/:new', to: 'attendances#new', as: 'new_attendance'
  
end
