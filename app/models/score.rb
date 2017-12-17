class Score < ApplicationRecord
  belongs_to :examination
  belongs_to :student

  default_scope -> { joins(:student).order('surname, name') }

  scope :find_by_pair, ->(student, examination) {
    where(student: student, examination: examination)
  }

  validates :score, allow_blank: true,
                    format: { with: /\A\d+(?:\.\d{0,2})?\z/,
                              message: :decimal_msg },
                    numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 100 },
                    if: proc { |c| c.score.present? }

  validates :examination, uniqueness: { scope: :student }
  validates :student, uniqueness: { scope: :examination }

  def passed?
    if score.present?
      score >= examination.min_score
    else
      false
    end
  end

  def present?
    score.present?
  end
  
end
