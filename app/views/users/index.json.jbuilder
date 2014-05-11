json.array!(@users) do |user|
  json.extract! user, :id, :username, :github_key
  json.url user_url(user, format: :json)
end
