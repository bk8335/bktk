class CreateIndexParts < ActiveRecord::Migration[5.1]
  def change
    create_table :index_parts do |t|
    	t.integer :index_id
    	t.string :ticker
    	t.string :name
    	t.string :industry
    	t.integer :number_of_shares
    	t.decimal :initial_price
    	t.decimal :price
    	t.datetime :price_last_updated_at

      t.timestamps
    end
  end
end
