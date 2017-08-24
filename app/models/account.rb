class Account < ApplicationRecord
  has_many :groups, dependent: :destroy
  validates_presence_of :name
end
