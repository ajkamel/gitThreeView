class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :sha
      t.string :committer
      t.integer :additions
      t.integer :deletions
      t.date :date
      t.references :repo
    end

    add_index :commits, :repo_id
  end
end
