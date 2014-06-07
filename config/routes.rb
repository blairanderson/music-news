MusicNews::Application.routes.draw do
  devise_for :accounts, :controllers => { :omniauth_callbacks => "accounts/omniauth_callbacks" }

  devise_scope :account do
   get 'sign_out', :to => 'devise/sessions#destroy'
  end

  root 'submissions#index'

  resources :submissions, except: [:edit, :update] do
    resource :publisher, only: [:show, :new, :create]
    member do
      get :resolve
    end
  end
  resource :static_pages, path: '/', only: [] do
    get :about
  end

  resources :songs, only: [:index, :show, :destroy, :update]
  resources :user_song_tags, only: [:index, :create, :destroy]

  resource :session, only: [:show, :create, :update, :destroy]
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  resource :bloodhound, only: [:create, :new]

#vanity-URLS
  get 'new'       => 'submissions#new'
  get 'feed'      => 'submissions#feed'
  get 'logout'    => 'sessions#destroy'
  get 'signout'   => 'sessions#destroy'
  get '/seainhd'  => redirect('http://www.seainhd.com')

#backbone routing
  get ':id'      => 'frontend#root'
  get ':id/:id'  => 'frontend#root'
end
