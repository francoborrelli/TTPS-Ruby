class AddDniToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :dni, :integer
    add_index :students, :dni
  end
end
