class Group < ApplicationRecord
  belongs_to :account
  validates_presence_of :account, :name
end
