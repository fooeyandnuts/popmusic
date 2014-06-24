class DropPaths < ActiveRecord::Migration
  def change
  	drop_table :paths
  end
end
