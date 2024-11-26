class Batch < ApplicationRecord
  belongs_to :experience
  has_many :bookings
end
