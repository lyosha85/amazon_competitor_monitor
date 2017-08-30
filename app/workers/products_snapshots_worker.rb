class ProductsSnapshotsWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(asin)
    return true if Product.where(asin: asin).last.was_checked_today?

    Rails.logger.info "Attempting to get data of #{asin}."

    snapshot_attributes = GetProductDetailsService.call(asin)
    last_snapshot = Snapshot.where(asin: asin).last
    last_snapshot.assign_attributes(snapshot_attributes) if last_snapshot

    # Only create a snapshot if something changed or brand new product
    if last_snapshot.blank? || last_snapshot.changed?
      Snapshot.create!(snapshot_attributes)
      Product.where(asin: asin).each{|p| p.update(last_checked: Time.zone.now)}
    else
      Rails.logger.info "#{asin} remained the same."
    end
  end

  def on_complete(status, options)
    # Notify users
  end

  def self.execute(asins)
    asins.each{|asin| self.perform_async(asin) }
  end
end
