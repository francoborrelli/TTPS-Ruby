class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.float :score                    , null: false
      t.belongs_to :examination         , foreign_key: true, index: true
      t.belongs_to :student             , foreign_key: true, index: true
      t.timestamps
    end
  end
end
