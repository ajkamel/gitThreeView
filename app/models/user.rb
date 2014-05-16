class User < ActiveRecord::Base

  has_many :repos

  def self.oauth_response(code)
    return JSON.parse(RestClient.post("https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET'], code: code}, { accept: :json }))
  end

  def self.new_client(response)
    return Octokit::Client.new :access_token => response["access_token"]
  end

  def get_repos(client)

    # Octokit::Client.new(access_token: access_token)

    @user_id = self.id
    client.repos.each do |repo|
        repo = Repo.create(
          title: repo.name,
          repo_path: repo.full_name,
          description: repo.description,
          owner: repo.owner.login,
          start_date: repo.created_at,
          update_date: repo.updated_at
           )

        repo.user_id = @user_id
        repo.save
    end

  end

end
