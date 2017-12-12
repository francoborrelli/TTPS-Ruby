class ChangeMinMark < ActiveRecord::Migration[5.1]
  def change
      rename_column :examinations, :min_mark, :min_score
  end
end
