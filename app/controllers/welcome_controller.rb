class WelcomeController < ApplicationController

  def index
    @graphs = Graph.all
  end

  def find_user
    @current_user = User.find_by github_access_token: session[:github_access_token]
    @users = User.search_users(params[:q], session[:github_access_token])
  end

end
