class Score < ApplicationRecord
  belongs_to :examination
  belongs_to :patient
end
