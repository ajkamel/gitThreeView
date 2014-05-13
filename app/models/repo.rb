class Repo < ActiveRecord::Base

  has_and_belongs_to_many :users

  def self.get_repos(client, name)  #Get Repo Data

      repo = client.repo(name)
      repo_data = repo.inject(Array.new) { |array, repo| array << {
        title:         repo[:name],
        description:  repo[:description],
        language:     repo[:language],
        owner:        repo[:owner][:login],
        avatar:       repo[:owner][:gravatar_id],
        start_date:   repo[:created_at],
        update_date:  repo[:updated_at]
        } }
      repo_data.each { |string| if string[:description] == nil then string[:description] = "" end }
      repo_data.sort_by { |date| date[:update_date] }.reverse
  end

  def self.repo_content(username, repo, github_access_token)
    client = Octokit::Client.new(access_token: github_access_token)
    data = client.contents("#{username}/#{repo}")
  end


end
