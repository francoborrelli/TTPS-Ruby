class CreateExaminations < ActiveRecord::Migration[5.1]
  def change
    create_table :examinations do |t|
      t.references :course        , foreign_key: true
      t.string :title             , null: false
      t.datetime :date            , null: false
      t.float :min_mark           , null: false

      t.timestamps
    end
  end
end
