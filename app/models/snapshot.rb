class Snapshot < ApplicationRecord
  validates_presence_of :title, :asin, :price_cents, :inventory
end
