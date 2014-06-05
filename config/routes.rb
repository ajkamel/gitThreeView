Rails.application.routes.draw do

  root to: 'sessions#index'

  resources :welcome, :only => [:index, :get_repo_data]
  resources :users, :only => [:show]

  get '/auth/:provider/callback' => "sessions#callback"
  # get "github/callback" => "sessions#callback"
  get "/logout" => "sessions#destroy"
  get '/repos/:id' => "welcome#get_commit_data"
  get '/repos/search' => "welcome#find_user"
  get '/demo/:id' => "sessions#demo"

end
