class Book < ApplicationRecord
  has_many :reviews
  has_many :authors

  validates :title, presence: true
  validates :pages, presence: true
  validates :year_pub, presence: true
  validates :publisher, presence: true
  validates :image, presence: true

  def avg_score
    self.reviews.average(:score)
  end

end
