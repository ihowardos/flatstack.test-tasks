Rails.application.routes.draw do

  resources :events
  resource :calendar, only: [:show], controller: :calendar

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'profiles/:id', to: 'profiles#show', as: 'user'
  get 'pages/about', to:'pages#show', page: 'about'
  get 'calendar/show'
  get 'all_events', to: 'all_events#index'
  get 'all_events/:date', to: 'all_events#index'

  root to: "pages/home", to: 'pages#show', page: 'home'
end
