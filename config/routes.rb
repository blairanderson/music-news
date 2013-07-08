MusicNews::Application.routes.draw do
  root 'submissions#index'
  get '/gtfo' => redirect("http://seainhd.com"), as: "gtfo"

  resources :submissions, path: "s", except: [:edit, :update, :destroy]
  resource :static_pages, path: "/", only: [] do
    get :about
  end

  #vanity-URLS 
  get '/new', to: 'submissions#new', as: 'new'
  get '/feed', to: 'submissions#feed', as: 'feed'
  get ':twitter', to: 'submissions#twitter', as: 'twitter_name'  
end
