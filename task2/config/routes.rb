Rails.application.routes.draw do
  get 'calendar/show'

  resources :events
  resource :calendar, only: [:show], controller: :calendar

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'profiles/:id', to: 'profiles#show', as: 'user'
  get 'pages/about', to:'pages#show', page: 'about'

  root to: "calendar#show"
end
