class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.timestamps
    end
  end
end
