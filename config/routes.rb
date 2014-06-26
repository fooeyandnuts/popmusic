Popmusic::Application.routes.draw do

  resources :courses
  resources :markers
  resources :songs
  
  post '/courses/:id' => 'courses#add_markers'

  get '/' => 'soundclouds#index'
  get '/soundclouds/feed' => 'soundclouds#feed', as: :feed
  get '/soundclouds/music' => 'soundclouds#music', as: :music
  get '/soundclouds/about' => 'soundclouds#about', as: :about
  post '/soundclouds/search' => 'soundclouds#search', as: :search 

  get '/sc1' => 'soundclouds#sc1', as: :sc1
  get '/soundcloud' => 'soundclouds#soundcloud'

end
