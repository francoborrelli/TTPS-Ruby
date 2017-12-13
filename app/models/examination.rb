class Examination < ApplicationRecord
  has_many :scores, dependent: :delete_all
  belongs_to :course

  validates :title, presence: true
  validates :date, presence: true
  validates :min_score, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: :decimal_msg }, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def passing_percentage
    (passing_students * 100.00) / students.size
  end

  def passing_students
    scores.select(&:passed?).size
  end

  def failed_students
    scores.size - passing_students
  end

  def absent_students
    students.size - scores.size
  end

  def students
    course.students
  end
end
