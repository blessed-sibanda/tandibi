Rails.application.routes.draw do
  get "posts/create"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_for :users
  authenticate :user do
    resources :timelines, only: %i[index show], param: :username
    resources :posts, only: %i[create show]
  end
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
