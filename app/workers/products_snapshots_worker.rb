class ProductsSnapshotsWorker
  include Sidekiq::Worker

  def perform(asin)
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
    debugger
    asins.each{|asin| self.perform_async(asin) }
  end
end

