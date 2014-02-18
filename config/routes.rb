Flirtatiously::Application.routes.draw do
  resources :users, except: [:index, :show] do
    resources :messages, only: [:new, :create] do
      get 'conversation', on: :collection
    end

    member do
      post "like"
    end
  end

  resource :session, only: [:new, :create, :destroy]

  resources :profiles

  resources :messages, only: [:index, :destroy]

  resources :questions, only: [:show, :create, :index] do
    post "answer"
    get "edit_answer"
    put "update_answer"
  end

  resources :responses, only: [:create, :update, :edit]
  #resources :likes, only: [:index, :destroy]

  root to: 'sessions#new'
end
