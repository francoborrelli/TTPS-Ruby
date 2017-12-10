class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :year, null: false

      t.timestamps
    end
    add_index :courses, :year, unique: true
  end
end
