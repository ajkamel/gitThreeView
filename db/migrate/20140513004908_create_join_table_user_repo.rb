class CreateJoinTableUserRepo < ActiveRecord::Migration
  def change
    create_join_table :users, :repos do |t|
      t.index [:user_id, :repo_id]
      t.index [:repo_id, :user_id]
    end
  end
end
