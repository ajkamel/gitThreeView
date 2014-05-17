class WelcomeController < ApplicationController

  before_action :signed_in?

  def index
        @current_user = User.find_by(github_access_token: session[:github_access_token])
        ##Looks for all the Repos to pass to the view if none exist it will search Octokit for them and seed
        if @current_user.repos.length < 1
          all_repos = @current_user.get_repos(client)
          @repos = @current_user.repos
        else
          @repos = @current_user.repos
        end
  end

  #Add this to the view later to search for user in database
  def find_user
    @current_user = User.find_by github_access_token: session[:github_access_token]
  end


  def get_commit_data
    repo = Repo.find(params[:id])
    #Fix this logic for later
    if repo.commits.length  < 2
      repo.get_repo_stats(client)
      @commit_data = repo.commits
    else
      @commit_data = repo.commits
    end
  end
end
