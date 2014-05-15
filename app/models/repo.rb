class Repo < ActiveRecord::Base

  belongs_to :users
  has_many :commits

  def get_repo_stats(access_token)
    Octokit::Client.new(access_token: access_token)

    commits = Octokit.commits(self.repo_path)
    @repo_url = self.repo_path
    @repo_id = self.id
    #Gets commits per repo with sha, name and date of commit
    commits.each do |commit|
        new_commit = Commit.create(
        sha: commit.sha,
        committer: commit.commit.author[:name],
        date: commit.commit.author[:date] )
        #Add stats through Octokit additon and deletions
        new_sha = commit.sha
        commit_stats = Octokit.commit(@repo_url, new_sha).stats
        new_commit.additions = commit_stats.additions
        new_commit.deletions = commit_stats.deletions
        new_commit.repo_id = @repo_id
        new_commit.save
    end

  end



end
