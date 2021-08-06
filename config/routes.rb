Rails.application.routes.draw do
  ## 客制 devise controllers 需指定目錄
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :stories do
    member do
      post :clap
    end
    resources :comments, only: [:create]
  end

  ## /@username/title_id
  get '@:username/:story_id', to: 'pages#show', as: 'story_page'

  get '@:username', to: 'pages#user', as: 'user_page'

  root 'pages#index'
end
