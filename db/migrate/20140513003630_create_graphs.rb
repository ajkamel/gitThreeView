class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.text :graph_key
      t.references :repo
    end
  end
end
