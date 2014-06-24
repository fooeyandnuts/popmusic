class DropRoutes < ActiveRecord::Migration
  def change
  	drop_table :routes
  end
end
