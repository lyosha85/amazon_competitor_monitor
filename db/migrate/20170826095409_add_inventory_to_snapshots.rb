class AddInventoryToSnapshots < ActiveRecord::Migration[5.1]
  def change
    add_column :snapshots, :inventory, :integer
  end
end
