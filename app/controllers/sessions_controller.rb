class SessionsController < ApplicationController

  def index
    @oauth_link = User.oauth_link
  end

  def callback
    oauth_response = User.oauth_response(params["code"])
    client = User.new_client(oauth_response).user
    session[:github_access_token] = oauth_response["access_token"]

    unless User.exists?(name: client.login)
      User.create(name: client.login, github_access_token: oauth_response["access_token"], avatar: "#{client.avatar}")
    end

    redirect_to welcome_index_path
  end

  def destroy
    session[:github_access_token] = nil
    redirect_to root_path
  end

end
