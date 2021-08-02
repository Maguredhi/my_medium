Rails.application.routes.draw do
  ## 客制 devise controllers 需指定目錄
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :stories

  root 'pages#index'
end
