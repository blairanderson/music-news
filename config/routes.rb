MusicNews::Application.routes.draw do
  root 'submissions#index'
  get '/gtfo' => redirect("http://seainhd.com"), as: "gtfo"

  resources :submissions, path: "s", except: [:edit, :update, :destroy] do 
    get 'publish', on: :member
  end
  resource :static_pages, path: "/", only: [] do
    get :about
  end

  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]


  #vanity-URLS 
  get '/new', to: 'submissions#new', as: 'new'
  get '/feed', to: 'submissions#feed', as: 'feed'
  get "/logout" => "sessions#destroy", :as => :logout
  get "/signout" => "sessions#destroy", :as => :signout
  get ':twitter', to: 'submissions#twitter', as: 'twitter_name'  
end
