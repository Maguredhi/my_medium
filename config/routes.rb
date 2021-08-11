Rails.application.routes.draw do
  ## 客制 devise controllers 需指定目錄
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :api do
    # 設定去接圖片的路徑，並導向 utils controller 的 upload_image action
    post :upload_image, to: 'utils#upload_image'
    resources :users, only: [] do
      member do
        # /api/users/:id/follow
        post :follow
      end
    end
    # /api/stories/:id/clap
    resources :stories, only: [] do
      member do
        post :clap
        post :bookmark
      end
    end
  end

  resources :users, only: [] do
    collection do
      get :pricing  # /users/pricing
      get :payment  # /users/payment
    end
  end

  resources :stories do
    resources :comments, only: [:create]
  end

  ## /@username/title_id
  get '@:username/:story_id', to: 'pages#show', as: 'story_page'

  get '@:username', to: 'pages#user', as: 'user_page'

  root 'pages#index'
end
