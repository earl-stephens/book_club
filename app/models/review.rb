class Review < ApplicationRecord
  belongs_to :book

  validates :title, presence: true
  validates :score, presence: true
  validates :user, presence: true
end
