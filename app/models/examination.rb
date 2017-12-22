class Examination < ApplicationRecord
  default_scope { order(:date) }
  before_save :standarize

  belongs_to :course
  has_many :scores, dependent: :restrict_with_error
  accepts_nested_attributes_for :scores, reject_if: proc { |a| a['score'].blank? }


  validate :proper_year
  validates :title, presence: true, uniqueness: { scope: :course }
  validates :date, presence: true
  validates :min_score, presence: true,
                        numericality: { greater_than_or_equal_to: 0,
                                        less_than_or_equal_to: 100 }

  def passing_percentage
    (passing_students * 100.00) / course.students.size
  end

  def passing_students
    scores.select(&:passed?).size
  end

  def failed_students
    scores.size - passing_students
  end

  def absent_students
    course.students.size - scores.size
  end

  private
  def proper_year
    range = years_range
    errors.add(:date, :invalid_year) unless date.present? && range === date.year 
  end

  def standarize
    self.min_score = min_score.round(2)
    self.title = title.titleize
  end

  def years_range
    course.year..(course.year + 1) unless course.nil?
  end

end
