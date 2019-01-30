class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.integer :age
      t.string :hometown
      t.text :image

      t.timestamps
    end
  end
end
