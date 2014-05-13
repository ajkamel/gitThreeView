Rails.application.routes.draw do

  root to: 'sessions#index'

  get '/auth/:provider/callback' => "sessions#callback"

  resources :welcome, :only => [:index]
  resources :users, :only => [:show]
  resources :repos, :only => [:index, :show, :create, :update, :destroy] do
  resources :graphs, shallow: true
  end

  # get "sessions/index"
  get "github/callback" => "sessions#callback"
  get "/logout" => "sessions#destroy"

end
