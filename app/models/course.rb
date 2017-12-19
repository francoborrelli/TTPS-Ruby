class Course < ApplicationRecord
  has_many :examinations, dependent: :restrict_with_error
  has_many :students, dependent: :restrict_with_error
  has_many :scores, through: :examinations

  validates :year, presence: true, uniqueness: true,
                   length: { is: 4 },
                   numericality: { only_integer: true }

  def min_year
    Time.zone.today.year - 35
  end

  def max_year
    Time.zone.today.year + 1
  end

  def time_range
    (min_year..max_year).to_a
  end
end
