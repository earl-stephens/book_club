class Author < ApplicationRecord
  has_many :book_authors, dependent: :delete_all
  has_many :books, through: :book_authors, dependent: :delete_all

  validates_presence_of :name
end
