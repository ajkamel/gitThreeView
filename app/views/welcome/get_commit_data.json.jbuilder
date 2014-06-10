json.title @repoinfo.title

json.array!(@commit_data) do |commit|
  json.extract! commit, :id, :sha, :committer, :additions, :deletions, :date, :repo_id
end
