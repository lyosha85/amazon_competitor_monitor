class Snapshot < ApplicationRecord
  validates_presence_of :asin

  def previous_snapshot # with the same asin
    Snapshot.where(asin: self.asin)
            .where("id < ?", id).last
  end
end
