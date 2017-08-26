class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :asin
      t.references :group, foreign_key: true
      t.datetime :last_checked, default: Time.at(0)

      t.timestamps
    end

    add_index :products, :asin
    add_index :products, :last_checked
  end
end
