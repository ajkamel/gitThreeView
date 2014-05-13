json.array!(@repos) do |repo|
  json.extract! repo, :id, :title, :description, :start_date, :update_date, :owner, :repo_image
  json.url repo_url(repo, format: :json)
end
