class Score < ApplicationRecord
  belongs_to :examination
  belongs_to :student

  default_scope -> {joins(:student).order("surname, name")
  } 

  validates :score, :allow_blank => true,
            format: { with: /\A\d+(?:\.\d{0,2})?\z/,
                      message: :decimal_msg },
            numericality: { greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 100 }, 
            if: Proc.new {|c| c.score.present?}

  validates :examination, uniqueness: { scope: :student }
  validates :student, uniqueness: { scope: :examination }

  scope :find_by_pair, ->(student, examination) { where(student: student, examination: examination) }

  def passed?
    if score
      score >= examination.min_score
    end
    false
  end

  def status
    if passed?
      :passed
    else
      :failed
    end
  end
end
