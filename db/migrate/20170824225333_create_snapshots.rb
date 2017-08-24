class CreateSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :snapshots do |t|
      t.string :title
      t.text :images
      t.text :features
      t.text :description
      t.integer :reviews_count
      t.integer :bsr
      t.string :bsr_category
      t.string :asin, null: false
      t.integer :price_cents

      t.timestamps
    end
    add_index :snapshots, :asin
  end
end
