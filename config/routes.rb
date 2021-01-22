Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :stories

  # /@username/title-123
  get '@:username/:story_id', to: 'pages#show', as: 'story_page'

  # /@username
  get '@:username', to: 'pages#user', as: 'user_page'

  root 'pages#index'
end
