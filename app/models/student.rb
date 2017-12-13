class Student < ApplicationRecord
  has_many :scores, dependent: :delete_all
  belongs_to :course

  validates :name, presence: true,
                   length: { in: 0..50 },
                   format: { with: /\A[a-zA-Z]+\z/,
                             message: :only_letters }
  validates :surname, presence: true,
                      length: { in: 0..50 },
                      format: { with: /\A[a-zA-Z]+\z/,
                                message: :only_letters }
  validates :s_number, presence: true,
                       uniqueness: { scope: :course },
                       length: { in: 0..10 },
                       format: { with: /\A[1-9]\d{0,6}(|.[\/][1-9]\d{0,2})\z/,
                                 message: :invalid_s_number }
  validates :email,
            presence: true, uniqueness: { scope: :course },
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
                      message: :invalid_email }

  validates :dni, presence: true,
                  uniqueness: { scope: :course },
                  length: { in: 6..11 },
                  numericality: { only_integer: true }

  def score_for_exam(exam)
    Score.find_by_pair(self, exam).first
  end

  def to_label
    "#{s_number} - #{name} #{surname}"
  end
end
