class AddColumnsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :name, :string
    add_column :courses, :rails, :string
    add_column :courses, :s, :string
  end
end
