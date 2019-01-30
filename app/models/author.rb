class Author < ApplicationRecord
  has_many :bookauthors
  has_many :books, through: :bookauthors

  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :hometown
  validates_presence_of :image
end
