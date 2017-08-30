class RemoveBsrCategoryFromSnapshots < ActiveRecord::Migration[5.1]
  def change
    remove_column :snapshots, :bsr_category, :string
  end
end
