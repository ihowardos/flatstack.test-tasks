Rails.application.routes.draw do
  resources :events
  resources :prifles

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'profiles/:id', to: 'profiles#show'

  root to: "events#index"
end
