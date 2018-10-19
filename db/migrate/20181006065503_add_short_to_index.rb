class AddShortToIndex < ActiveRecord::Migration[5.1]
  def change
    add_column :indices, :short, :boolean, default: false
  end
end
