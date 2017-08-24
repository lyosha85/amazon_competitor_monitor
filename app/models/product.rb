class Product < ApplicationRecord
  belongs_to :group
  has_many :snapshots

  validates_presence_of :asin
  validate :check_max_8_products_per_group

  def check_max_8_products_per_group
    if self.group
      errors.add :group, 'Max 8 products per group.' if self.group.products.count >= 8
    end
  end
end
