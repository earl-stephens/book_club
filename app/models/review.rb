class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :title, presence: true
  validates :score, presence: true, :inclusion => {in: 1..5}
  validates :review_text, presence: true

  def self.select_sort(option)
    if option == "newest_first"
      order(created_at: :desc)
    elsif option == "oldest_first"
      order(created_at: :asc)
    end
  end
end
