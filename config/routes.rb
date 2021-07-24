Rails.application.routes.draw do
  namespace :settings do
    get "users/show"
    get "users/update"
  end
  get "posts/create"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_for :users
  authenticate :user do
    resources :timelines, only: %i[index show], param: :username
    resources :posts, only: %i[create show]
    resources :bonds, param: :username do
      member do
        post :follow
        post :unfollow
        get :followers
        get :following
        post :reject
        post :accept
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :places, only: %i[index]
    end
  end

  namespace :settings do
    resource :user, only: %i[show update]
  end
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
