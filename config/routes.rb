MusicNews::Application.routes.draw do
  root 'frontend#root'

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

  #vanity-URLS
  get 'new'       => 'submissions#new'
  get 'feed'      => 'submissions#feed'
  get 'logout'    => 'sessions#destroy'
  get 'signout'   => 'sessions#destroy'
  get '/seainhd'  => redirect('http://www.seainhd.com')

  # backbone catching
  get ':id'      => 'frontend#root'
  get ':id/:id'  => 'frontend#root'
end
