class Course < ApplicationRecord
    has_many :students

    validates :year, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: :minYear,  less_than_or_equal_to: :maxYear }

    def minYear
        Date.today.year - 35
    end

    def maxYear
        Date.today.year + 1
    end
end
