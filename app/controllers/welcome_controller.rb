class WelcomeController < ApplicationController

  before_action :signed_in?

  def index

        @current_user = User.find_by(github_access_token: session[:github_access_token])

        ##Looks for all the Repos to pass to the view if none exist it will search Octokit for them and seed
        if @current_user.repos.length < 1
          all_repos = @current_user.get_repos(client, @current_user.github_access_token)
          repos_data = Repo.get_repo_stats(session[:github_access_token])
          @repos = @current_user.repos
        else
          @repos = @current_user.repos
        end

  end

  def find_user
    @current_user = User.find_by github_access_token: session[:github_access_token]
  end


  def get_commit_data

    repo = Repo.find(params[:id])

    if repo.commits.length < 1
      repo.get_repo_stats(client.access_token)
      @commit_data = repo.commits
    else
      @commit_data = repo.commits
    end

  end


end
