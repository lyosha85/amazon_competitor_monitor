class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.references :account, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
