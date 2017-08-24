class Snapshot < ApplicationRecord
  belongs_to :product, foreign_key: 'asin'
end
