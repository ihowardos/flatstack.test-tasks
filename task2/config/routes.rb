Rails.application.routes.draw do
  resources :events

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'profiles/:id', to: 'profiles#show', as: 'user'
  get 'pages/about', to:'pages#show', page: 'about'
  
  root to: "pages#show", page: "home"
end
