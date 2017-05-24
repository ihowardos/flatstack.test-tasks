Rails.application.routes.draw do
  resources :events
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root to: "events#index"
end
