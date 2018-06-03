class AddWordcountToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :wordcount, :integer
  end
end
