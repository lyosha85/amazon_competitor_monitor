class Snapshot < ApplicationRecord
  belongs_to :product, foreign_key: 'asin'
  validates_presence_of :title, :asin, :price_cents, :inventory
end
