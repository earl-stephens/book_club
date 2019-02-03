class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :title, presence: true
  validates :score, presence: true
  validates :review_text, presence: true
end
