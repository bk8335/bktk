class AddCurrencyToPosition < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :currency, :string, default: "$"
  end
end
