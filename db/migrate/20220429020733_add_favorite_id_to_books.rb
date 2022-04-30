class AddFavoriteIdToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :favorite_id, :integer
  end
end
