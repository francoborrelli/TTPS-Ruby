class Examination < ApplicationRecord
  belongs_to :course

  validates :title, presence: true
  validates :date, presence: true
  validates :s_number, presence: true, uniqueness: {scope: :course}

end
