class CreateIndices < ActiveRecord::Migration[5.1]
  def change
    create_table :indices do |t|
      t.string :name
      t.decimal :starting_level
      t.decimal :devaluer

      t.timestamps
    end
  end
end
