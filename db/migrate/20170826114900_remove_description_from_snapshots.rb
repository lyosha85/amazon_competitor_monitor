class RemoveDescriptionFromSnapshots < ActiveRecord::Migration[5.1]
  def change
    remove_column :snapshots, :description, :string
  end
end
