MusicNews::Application.routes.draw do
  root 'submissions#index'
  get '/seainhd' => redirect("http://www.seainhd.com"), as: "seainhd"

  resources :submissions, path: "s", except: [:edit, :update] do 
    resource :publisher, only: [:show, :new, :create]
  end
  resource :static_pages, path: "/", only: [] do
    get :about
  end

  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]


  #vanity-URLS 
  get '/more' => 'submissions#more', as: :more
  get '/new', to: 'submissions#new', as: :new
  get '/feed', to: 'submissions#feed', as: :feed
  get "/logout" => "sessions#destroy", as: :logout
  get "/signout" => "sessions#destroy", as: :signout
  get ':twitter', to: 'submissions#twitter', as: :twitter_name
end
