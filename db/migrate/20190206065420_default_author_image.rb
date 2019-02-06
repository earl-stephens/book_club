class DefaultAuthorImage < ActiveRecord::Migration[5.1]
  def change
    change_column :authors, :image, :text, default:
    "https://neilpatel.com/wp-content/uploads/2016/05/writer.jpg"
  end
end
