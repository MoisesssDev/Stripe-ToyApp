class Experience < ApplicationRecord
  belongs_to :store
  has_many :batches
end
