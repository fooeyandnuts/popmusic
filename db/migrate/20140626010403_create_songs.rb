class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.references :marker, index: true

      t.timestamps
    end
  end
end
