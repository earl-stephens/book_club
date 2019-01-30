class AddImageToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :image, :text
    add_column :books, :publisher, :string
  end
end
