Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'reviews#index'

  get    '/login',  to: 'sessions#new', as: 'login'
  post   '/login',  to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'

  get '/auth/github/callback', to: 'sessions#github_auth'

  resources :users do 
    resources :reviews, only: [:inex, :show, :new, :edit]
  end 

  resources :reviews do 
    resources :comments, only: [:show] 
  end
end
