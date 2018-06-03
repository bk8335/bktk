class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.string :asset
      t.string :ticker
      t.string :long_or_short
      t.decimal :initial_price
      t.integer :post_id

      t.timestamps
    end
  end
end
