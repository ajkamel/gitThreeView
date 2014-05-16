Rails.application.routes.draw do

  root to: 'sessions#index'

  get '/auth/:provider/callback' => "sessions#callback"

  resources :welcome, :only => [:index, :get_repo_data]
  resources :users, :only => [:show]

  get "github/callback" => "sessions#callback"
  get "/logout" => "sessions#destroy"
  get '/repos/:id' => "welcome#get_commit_data"
  get '/repos/search' => "welcome#find_user"


end
