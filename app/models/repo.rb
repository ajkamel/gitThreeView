class Repo < ActiveRecord::Base

  has_and_belongs_to_many :users

  def get_repo_stats(repo_url)
    # client = Octokit::Client.new(access_token: current_user.github_access_token)

    commits = Octokit.commits(repo_url)
    #Gets commits per repo with sha, name and date of commit
    commits.each do |commit|
        new_commit = Commit.create(
        sha: commit.sha,
        committer: commit.commit.author[:name],
        date: commit.commit.author[:date] )

        #Add stats through Octokit
        new_sha = commit.sha
        new_commit.additions = Octokit.commit(repo_url, new_sha).stats.additions
        new_commit.deletions = Octokit.commit(repo_url, sha).stats.deletions

    end

  end



end
