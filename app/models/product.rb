class Product < ApplicationRecord
  belongs_to :group
  validates_presence_of :asin
end
