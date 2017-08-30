class Changes
  def self.in_date(group, date)
    snapshots = Snapshot.where(asin: group.asins.uniq)
                        .where("created_at >= ? AND created_at < ?",
                          date.beginning_of_day, date.end_of_day)
    results = []

    snapshots.each do |snapshot|
      result = { 'new' => snapshot.attributes.except('id', 'created_at', 'updated_at') }
      previous = snapshot.previous_snapshot
      result['old'] = snapshot.previous_snapshot.attributes.except('id', 'created_at', 'updated_at') if previous
      results << result
    end
    results
  end
end
