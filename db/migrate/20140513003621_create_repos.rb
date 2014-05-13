class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :title
      t.text :description
      t.string :owner
      t.string :repo_image
      t.date :start_date
      t.date :update_date
    end
  end
end
