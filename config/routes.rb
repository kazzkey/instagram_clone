Rails.application.routes.draw do
  root to: 'pictures#index'
  resources :favorites, only: [:create, :destroy]
  resources :pictures do
    collection do
      post :confirm
    end
    resources :comments, only: [:create, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get :favorites
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
