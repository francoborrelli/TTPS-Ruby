class Examination < ApplicationRecord
  before_create :build_scores
  before_save :standarize

  belongs_to :course

  has_many :scores, dependent: :delete_all
  accepts_nested_attributes_for :scores, allow_destroy: true

  validates :title, presence: true, uniqueness: { scope: :course }

  validates :date, presence: true
  validate :proper_year

  validates :min_score, presence: true,
                        numericality: { greater_than_or_equal_to: 0,
                                        less_than_or_equal_to: 100 }

  def passing_percentage
    (passing_students * 100.00) / students.size
  end

  def passing_students
    scores.select(&:passed?).size
  end

  def failed_students
    scores.select(&:present?).size - passing_students
  end

  def absent_students
    scores.reject(&:present?).size
  end

  delegate :students, to: :course

  private
  def standarize
    self.min_score = self.min_score.round(2)
    self.title = self.title.downcase.capitalize
  end

  def proper_year
    range = years_range
    errors.add(:date, :invalid_year) unless date.present? && range === date.year
  end

  def years_range
    course.year..(course.year + 1)
  end

  def build_scores
    course.students.each do |student|
      scores.build(student: student)
    end
 end
end
