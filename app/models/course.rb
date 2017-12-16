class Course < ApplicationRecord
  has_many :examinations, dependent: :delete_all
  has_many :students, dependent: :delete_all
  has_many :scores, through: :examinations

  validates :year, presence: true, uniqueness: true,
                   length: { is: 4 },
                   numericality: { only_integer: true,
                                   greater_than_or_equal_to: :min_year,
                                   less_than_or_equal_to: :max_year }

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