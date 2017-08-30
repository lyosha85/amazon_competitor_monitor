class ProductsSnapshotsWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(asin)
    return true if Product.where(asin: asin).last.was_checked_today?

    Rails.logger.info "Attempting to get data of #{asin}."

    snapshot_attributes = GetProductDetailsService.call(asin)
    snapshot = Snapshot.new(snapshot_attributes)
    new_snapshot_attributes = snapshot.attributes.except('id', 'created_at',
                                                         'updated_at')
    previous_snapshot_attributes = Snapshot.where(asin: asin).last
                                           .attributes.except('id',
                                                              'created_at',
                                                              'updated_at')
    # Only create a snapshot if something changed
    unless snapshot_attributes == previous_snapshot_attributes
      snapshot.save!
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
