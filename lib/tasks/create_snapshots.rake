namespace :snapshots do
  desc %Q{ ›› Create amazon product snapshots }
  task generate: :environment do
    asins = Product.require_new_snapshots.pluck(:asin).uniq
    ProductsSnapshotsWorker.execute(asins)
  end
end


