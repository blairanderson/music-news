MusicNews::Application.routes.draw do
  root 'submissions#backbone'
  get '/seainhd' => redirect('http://www.seainhd.com')
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]

  resources :submissions, except: [:edit, :update] do
    resource :publisher, only: [:show, :new, :create]
    member do
      get :resolve
    end
  end
  resource :static_pages, path: '/', only: [] do
    get :about
  end

  resources :songs, only: [:index, :show, :destroy]

  #vanity-URLS
  get 'new' => 'submissions#new'
  get 'feed' => 'submissions#feed'
  get 'logout' => 'sessions#destroy'
  get 'signout' => 'sessions#destroy'
  get ':id' => 'submissions#backbone_redirect'
end
