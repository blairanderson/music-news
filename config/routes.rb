MusicNews::Application.routes.draw do

  root 'posts#index'
  get '/popular' => 'posts#index', as: :popular
  get '/greatest' => 'posts#index', as: :greatest
  get '/latest' => 'submissions#index', as: :latest

  # login / omniauth routes
  devise_for :accounts, :controllers => { :omniauth_callbacks => "accounts/omniauth_callbacks" }
  match '/profile/:id/finish_signup' => 'accounts#finish_signup', via: [:get, :patch], :as => :finish_signup
  devise_scope :account do
    get 'sign_out' => 'devise/sessions#destroy'
    get 'signout'  => 'devise/sessions#destroy'
    get 'logout'   => 'devise/sessions#destroy'
  end

  get 'profile' => 'accounts#profile', as: :profile
  get 'accounts/:id' => 'accounts#show', as: :account

  resources :submissions, except: [:edit, :update] do
    resource :publisher, only: [:show, :new, :create]
    member do
      get :resolve
    end
  end

  resource :static_pages, path: '/', only: [] do
    get :about
  end

  resources :webhooks, only: [:create]
  resources :posts, only: [:index, :show]

  resources :songs, only: [:index, :show, :destroy, :update]
  resources :user_song_tags, only: [:index, :create, :destroy]

  resource :bloodhound, only: [:create, :new]

  #vanity-URLS
  get 'new'       => 'submissions#new'
  get 'feed'      => 'submissions#feed'
end
