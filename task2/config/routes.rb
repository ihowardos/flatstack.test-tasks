Rails.application.routes.draw do

  resources :events do
    resources :comments, shallow: true, only: [:create, :update, :destroy]
  end

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'user/:id', to: 'profiles#show', as: 'user'
  get 'pages/about', to:'pages#show', page: 'about'
  get 'all_events', to: 'all_events#index'
  get 'all_events/:date', to: 'all_events#index'

  root to: "pages/home", to: 'pages#show', page: 'home'
end
