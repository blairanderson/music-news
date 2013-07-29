MusicNews::Application.routes.draw do
  root 'submissions#index'
  get '/seainhd' => redirect('http://www.seainhd.com')
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]

  resources :submissions, path: 's', except: [:edit, :update] do 
    resource :publisher, only: [:show, :new, :create]
  end
  resource :static_pages, path: '/', only: [] do
    get :about
  end

  resources :songs, only: [:index, :show] do
    collection do 
      get :playlist
    end
    member do 
      get :resolve
    end
  end


  #vanity-URLS 
  get 'new' => 'submissions#new'
  get 'more' => 'submissions#more'
  get 'feed' => 'submissions#feed'
  get 'logout' => 'sessions#destroy'
  get 'signout' => 'sessions#destroy'
  get ':twitter' => 'submissions#twitter', as: :twitter_name
end
