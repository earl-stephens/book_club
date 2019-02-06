class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors

  validates :title, presence: true, uniqueness: true
  validates :pages, presence: true
  validates :year_pub, presence: true

  def avg_score
    if self.reviews.count == 0
      0
    else
      self.reviews.average(:score).round(1)
    end
  end

  def self.select_sort(option)
    if option == "random"
      self.all.shuffle
    elsif option == "avg_rating_asc"
      self.left_joins(:reviews).group(:id).order("avg(reviews.score) asc nulls last, books.title asc")
    elsif option == "avg_rating_desc"
      self.left_joins(:reviews).group(:id).order("avg(reviews.score) desc nulls last, books.title asc")
    elsif option == "num_pages_asc"
      self.order(:pages)
    elsif option == "num_pages_desc"
      self.order(pages: :desc)
    elsif option == "num_reviews_asc"
      left_joins(:reviews)
      .group(:id)
      .order("reviews.count asc, books.title asc")
    elsif option == "num_reviews_desc"
      left_joins(:reviews)
      .group(:id)
      .order("reviews.count desc, books.title asc")
    end
  end

  def self.top_books
    joins(:reviews).group(:id).order("avg(reviews.score) desc, books.title asc")
  end

  def self.worst_books
    joins(:reviews).group(:id).order("avg(reviews.score) asc, books.title asc")
  end

  def top_review
    self.reviews.order(score: :desc).limit(1).first
  end

  def top_reviews
    self.reviews.order(score: :desc).limit(3)
  end

  def bottom_reviews
    self.reviews.order(score: :asc).limit(3)
  end

  def other_authors(name)
    self.authors.where.not(name: name).order(:name)
  end

end
