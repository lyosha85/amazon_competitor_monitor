class Group < ApplicationRecord
  belongs_to :account
  has_many :products

  validates_presence_of :account, :name
  validate :max_10_groups_per_account, on: :create

  def max_10_groups_per_account
    errors.add :group, 'Max 10 groups per account.' if self.account.groups.count >= 10
  end
end
