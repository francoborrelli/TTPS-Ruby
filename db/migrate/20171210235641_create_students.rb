class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :surname                       , null: false
      t.string :name                          , null: false
      t.string :s_number                      , null: false
      t.string :email                         , null: false
      t.belongs_to :course, foreign_key: true , null: false
      t.timestamps
    end
  end
end
