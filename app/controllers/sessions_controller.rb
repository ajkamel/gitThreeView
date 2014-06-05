class SessionsController < ApplicationController

  def index
    user = User.all.first.github_access_token
    @oauth_link = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}"
    @demouser= "/github/callback/#{user}"
  end

  def callback
    oauth_response = User.oauth_response(params["code"])
    client = User.new_client(oauth_response)
    session[:github_access_token] = oauth_response["access_token"]

    unless User.exists?(name: client.login)
      User.create(name: client.login,
        github_access_token: oauth_response["access_token"],
        avatar: client.user.avatar_url,
        email: client.user.email )
    end
    redirect_to welcome_index_path
  end

  def destroy
    session[:github_access_token] = nil
    redirect_to root_path
  end

end
