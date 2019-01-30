class AddTextToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :review_text, :text
    remove_column :reviews, :user
  end
end
