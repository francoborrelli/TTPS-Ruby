class Score < ApplicationRecord
  belongs_to :examination
  belongs_to :student

  scope :find_by_pair, ->(student, examination) { where(student: student, examination: examination) }

  def passed?
    score >= examination.min_score
  end
end
