class Course < ApplicationRecord
    has_many :examinations, dependent: :delete_all
    has_many :students, dependent: :delete_all

    validates :year, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: :min_year,  less_than_or_equal_to: :max_year }

    def min_year
        Date.today.year - 35
    end

    def max_year
        Date.today.year + 1
    end

    def time_range
        (self.min_year..self.max_year).to_a
    end
end
