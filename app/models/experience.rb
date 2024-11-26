class Experience < ApplicationRecord
  belongs_to :store
  has_one :batch
end
