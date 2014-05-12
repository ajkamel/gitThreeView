class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  private

  def current_user
    User.find_by(github_key: session[:github_key]) if session[:github_key]
  end

  def client
    Octokit::Client.new(access_token: session[:github_key])
  end

  def signed_in?
    redirect_to root_path if !current_user
  end

end
