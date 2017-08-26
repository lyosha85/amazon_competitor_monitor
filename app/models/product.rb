class Product < ApplicationRecord
  belongs_to :group
  has_many :snapshots, foreign_key: 'asin'

  validates_presence_of :asin
  validate :check_max_8_products_per_group

  scope :require_new_snapshots, -> { where("last_checked <= ? ", Time.zone.now.beginning_of_day )}

  def check_max_8_products_per_group
    if self.group
      errors.add :group, 'Max 8 products per group.' if self.group.products.count >= 8
    end
  end
end
