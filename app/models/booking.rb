class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :experience
  has_one :batch
end
