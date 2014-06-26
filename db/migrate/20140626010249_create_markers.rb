class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.float :latitude
      t.float :longitude
      t.references :course, index: true

      t.timestamps
    end
  end
end
