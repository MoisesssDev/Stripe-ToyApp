class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :batch
  enum status: { pending: 0, confirmed: 1, canceled: 2, refunded: 3 }
end
