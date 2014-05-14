class User < ActiveRecord::Base

  has_and_belongs_to_many :repos

  def self.oauth_response(code)
    return JSON.parse(RestClient.post("https://github.com/login/oauth/access_token", {client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET'], code: code}, { accept: :json }))
  end

  def self.new_client(response)
    return Octokit::Client.new :access_token => response["access_token"]
  end

  def self.get_repos
    client = Octokit::Client.new(access_token: github_access_token)

    client.repos.each do |repo|
        repo = Repo.new( title: repo.full_name )
    end
  end

end
