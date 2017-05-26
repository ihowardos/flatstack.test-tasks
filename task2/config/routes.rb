Rails.application.routes.draw do
  resources :events

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'profiles/:id', to: 'profiles#show', as: 'user'

  root to: "pages#show", page: "home"
end
