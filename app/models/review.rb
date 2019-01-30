class Review < ApplicationRecord
  belongs_to :book

  validates :title, presence: true
  validates :score, presence: true
  validates :review_text, presence: true
end
