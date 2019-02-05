class AddDefaultUserImage < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :image, :text, default:
    "https://ae01.alicdn.com/kf/HTB1ebxFSXXXXXcCaXXXq6xXFXXX1/18cm-14-6cm-Interesting-Vinyl-Decal-Karate-Stick-Figure-Man-Ninja-Car-Sticker-Black-Silver-S6.jpg_640x640.jpg"
  end
end
