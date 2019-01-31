class Book < ApplicationRecord
  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :title, presence: true
  validates :pages, presence: true
  validates :year_pub, presence: true
  validates :publisher, presence: true
  validates :image, presence: true

  def avg_score
    if self.reviews.count == 0
      0
    else
      self.reviews.average(:score)
    end
  end

  def self.select_sort(option)
    if option == "avg_rating_asc"
      self.order(avg_score)
    elsif option == "avg_rating_desc"
      self.order(avg_score)
    elsif option == "num_pages_asc"
      self.order(:pages)
    elsif option == "num_pages_desc"
      self.order(pages: :desc)
    elsif option == "num_reviews_asc"
      self.order(book.reviews.count)
    elsif option == "num_reviews_desc"
      self.order(book.reviews.count :desc)
    end
  end

end
