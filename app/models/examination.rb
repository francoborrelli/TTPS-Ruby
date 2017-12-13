class Examination < ApplicationRecord
  has_many :scores, dependent: :delete_all
  belongs_to :course

  validates :title, presence: true
  validates :date, presence: true
  validates :min_score, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: :decimal_msg }, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
