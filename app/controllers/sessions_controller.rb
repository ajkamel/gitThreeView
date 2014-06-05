class SessionsController < ApplicationController

  def index
    @oauth_link = "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}"
    @demouser= "/demo"
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

  def demo
    demoID = User.find_by(name: "ajkamel").github_access_token
    client = User.new_client(demoID)
    session[:github_access_token] = demoID
    redirect_to welcome_index_path
  end

  def destroy
    session[:github_access_token] = nil
    redirect_to root_path
  end

end
