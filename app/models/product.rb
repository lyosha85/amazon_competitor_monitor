class Product < ApplicationRecord
  MAX_PER_GROUP = 8

  belongs_to :group

  before_validation :set_asin_from_url, if: -> { self.amazon_url.present? && self.asin.blank? }

  validates_presence_of :asin, message: 'You need to enter an asin or url'
  validates_length_of :asin, is: 10
  validate :check_max_products_per_group

  scope :require_new_snapshots, -> { where("last_checked <= ? ", Time.zone.now.beginning_of_day )}
  scope :snapshots, -> { Snapshot.where(asin: asin) }

  def check_max_products_per_group
    if self.group
      errors.add :group, "Max #{MAX_PER_GROUP} products per group." if self.group.products.count >= MAX_PER_GROUP
    end
  end

  def amazon_url=(url)Array
    #10 alphanumeric charaters after '/dp/'
    url.scan(/dp\/([0-9,A-Z]{10})/)[0].first if url.present?
  end

  def amazon_url
    "https://www.amazon.com/dp/#{self.asin}" if asin && self.persisted?
  end

  def set_asin_from_url
    self.asin = amazon_url
  end

  def was_checked_today?
    self.last_checked >= Time.zone.now.beginning_of_day
  end
end


