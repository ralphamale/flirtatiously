Flirtatiously::Application.routes.draw do
  resources :users, except: [:index] do
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
  
  resources :questions do
    post "answer"
  end
  
  #resources :likes, only: [:index, :destroy]


end
