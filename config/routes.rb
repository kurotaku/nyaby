Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'dbmap', to: 'static_pages#dbmap'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  get 'mypage', to: 'users#mypage'
  resources :users
  
  resources :spots do
    member do
      get :reviews
      resources :reviews, param: :review_id
    end
  end

  resources :categories
  
  get '/location/', to: 'spots#location'
  get '/prefs/', to: 'spots#prefs'
  get '/prefs/:pref', to: 'spots#pref', as: 'pref'
end
