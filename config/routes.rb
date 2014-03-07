Dummyapp::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/home',    to: 'static_pages#home',    via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match 'confirm_user/:token', to: 'sessions#confirm_user', via: 'get', as: :confirmation

  root  'static_pages#home'
 end
