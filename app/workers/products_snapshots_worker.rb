class ProductsSnapshotsWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(asin)
    return true if Product.where(asin: asin).last.was_checked_today?

    Rails.logger.info "Attempting to get data of #{asin}."

    snapshot_attributes = GetProductDetailsService.call(asin)
    snapshot = Snapshot.new(snapshot_attributes)

    if snapshot.save
      Product.where(asin: asin).each{|p| p.update(last_checked: Time.zone.now)}
    else
      Rails.logger.warn "Failed to get data for #{asin}"
      Rails.logger.warn snapshot.errors.full_messages
    end
  end

  def on_complete(status, options)
    # Notify users
  end

  def self.execute(asins)
    asins.each{|asin| self.perform_async(asin) }
  end
end
