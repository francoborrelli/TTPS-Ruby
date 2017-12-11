class Student < ApplicationRecord
  belongs_to :course

  validates :name, presence: true, length: { in: 0..50 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :surname, presence: true, length: { in: 0..50 }, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" } 
  validates :s_number, presence: true, uniqueness: {scope: :course}, length: { in: 0..10 }, format: { with: /\A[1-9]\d{0,6}(|.[\/][1-9]\d{0,2})\z/, message: "invalid student number" } 
  validates :email, presence: true, uniqueness: {scope: :course}
end
