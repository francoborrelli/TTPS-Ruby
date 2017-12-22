class Student < ApplicationRecord
  default_scope { order('surname, name') }

  before_save :standarize_name

  belongs_to :course
  has_many :scores, dependent: :restrict_with_error

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
                       length: { in: 1..10 },
                       format: { with: /\A\d{1,6}.[\/]\d\z/,
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
    scores.find_by(examination: exam)
  end

  def took_exam?(exam)
    score_for_exam(exam).present?
  end

  def full_name
    "#{name} #{surname}"
  end

  private

  def standarize_name
    self.name = name.titleize
    self.surname = surname.titleize
  end
end
