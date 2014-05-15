class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :title
      t.string :repo_path
      t.text :description
      t.string :owner
      t.date :start_date
      t.date :update_date
      t.references :user
    end

    add_index :repos, :user_id
  end
end
