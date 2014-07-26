class AddTitleToMarkers < ActiveRecord::Migration
  def change
  	change_table :markers do |t|
		t.string :title
		end
  end
end
