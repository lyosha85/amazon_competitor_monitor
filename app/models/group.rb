class Group < ApplicationRecord
  MAX_PER_ACCOUNT = 10
  belongs_to :account
  has_many :products, dependent: :destroy

  validates_presence_of :account, :name
  validate :max_groups_per_account, on: :create

  accepts_nested_attributes_for :products, reject_if: :all_blank,
                                                           allow_destroy: true

  def max_groups_per_account
    errors.add :group, "Max #{MAX_PER_ACCOUNT} groups per account." if self.account.groups.count >= MAX_PER_ACCOUNT
  end
end
