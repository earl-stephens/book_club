class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name

  def self.top_reviewers
    joins(:reviews)
    .group(:id)
    .order("reviews.count desc, users.name asc")
  end

  def number_reviews
    reviews.count
  end
end
