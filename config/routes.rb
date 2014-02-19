MusicNews::Application.routes.draw do
  root 'submissions#backbone'

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
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]

  #vanity-URLS
  get 'new'       => 'submissions#new'
  get 'feed'      => 'submissions#feed'
  get 'logout'    => 'sessions#destroy'
  get 'signout'   => 'sessions#destroy'
  get '/seainhd'  => redirect('http://www.seainhd.com')

  # backbone redirects
  get ':id' => 'submissions#backbone_redirect'
  get '/song/:id' => 'songs#backbone_redirect'
end
