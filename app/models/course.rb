class Course < ApplicationRecord
  
  scope :ordered_by_year, -> { order(year: :desc) }

  has_many :examinations, dependent: :restrict_with_error
  has_many :students, dependent: :restrict_with_error
  has_many :scores, through: :examinations

  validates :year, presence: true, uniqueness: true,
                   length: { is: 4 },
                   numericality: { only_integer: true },
                   inclusion: { in: 1950..(Time.zone.today.year + 5) }

end
