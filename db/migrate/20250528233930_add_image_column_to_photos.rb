class AddImageColumnToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :image, :string
  end
end
