class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors

  validates_presence_of :name
  #validates_presence_of :age
  #validates_presence_of :hometown
  #validates_presence_of :image
end
