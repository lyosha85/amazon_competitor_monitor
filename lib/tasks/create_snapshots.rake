namespace :snapshots do
  desc %Q{ ›› Create amazon product snapshots }
  task generate: :environment do
    :environment
    asins = Product.require_new_snapshots.pluck(:asin)
    asins.each do |asin|
        product_details = GetProductDetailsService.call(asin)
        snapshot = Snapshot.new(product_details)
        snapshot.product = Product.find_by(asin: asin)
        if snapshot.save
          Product.where(asin: asin).each{|p| p.update(last_checked: Time.zone.now)}
        else
          Rails.logger.warn "Failed to save snapshot for #{asin} on #{Time.zone.now}"
          Rails.logger.warn snapshot.errors.full_messages
        end
    end
  end
end


