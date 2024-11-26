class Experience < ApplicationRecord
  belongs_to :store
  has_many :bookings
  has_many :batches
end
