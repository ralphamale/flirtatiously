Flirtatiously::Application.routes.draw do
  resources :users, except: [:index, :show, :edit] do
    resources :messages, only: [:new, :create] do
      get 'conversation', on: :collection
    end

    member do
      post "like"
    end
  end

  resources :photos, only: [:new, :create, :destroy]

  resources :notifications, only: [:index] do
    put "read", on: :collection
  end

  resources :status_messages, only: [:index, :create, :delete, :new]

  resources :ratings, only: [:create]

  resource :user_filter, only: [:update]
  resource :session, only: [:new, :create, :destroy]

  resources :profiles, except: [:new] do
    get "random", on: :collection
  end

  resources :messages, only: [:index, :destroy] do
    get 'sent', on: :collection
  end

  resources :questions, only: [:show, :create, :index] do
    post "answer"
    get "edit_answer"
    put "update_answer"
    get "random", on: :collection
  end



  resources :responses, only: [:create, :update, :edit]
  #resources :likes, only: [:index, :destroy]
  get '/auth/:provider/callback', to: 'sessions#create'
  root to: 'status_messages#index'
end
