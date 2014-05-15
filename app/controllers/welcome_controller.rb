class WelcomeController < ApplicationController

  def index
      if Repo.exists?(owner: params[:username])
          repos = Repo.where(owner: params[:username])
      else

        @current_user = User.find_by github_access_token: session[:github_access_token]

        all_repos = @current_user.get_repos
        repos_data = Repo.get_repo_stats(session[:github_access_token])
      end

  end

  def find_user
    @current_user = User.find_by github_access_token: session[:github_access_token]
  end

end
