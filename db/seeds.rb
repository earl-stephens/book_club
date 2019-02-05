# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require_relative '../app/models/book.rb'
require_relative '../app/models/review.rb'
require_relative '../app/models/author.rb'
require_relative '../app/models/user.rb'

Book.destroy_all
Review.destroy_all
Author.destroy_all
User.destroy_all

book_1 = Book.create(title: "Harry Potter and the Prisoner of Azkaban", pages: 435, year_pub: 1999, image: "https://upload.wikimedia.org/wikipedia/en/a/a0/Harry_Potter_and_the_Prisoner_of_Azkaban.jpg", publisher: "Bloomsbury", created_at: 5.days.ago, updated_at: 2.days.ago)
book_2 = Book.create(title: "Harry Potter and the Half-Blood Prince", pages: 652, year_pub: 2005, image: "https://upload.wikimedia.org/wikipedia/en/f/f0/Harry_Potter_and_the_Half-Blood_Prince.jpg", publisher: "Bloomsbury", created_at: 5.days.ago, updated_at: 2.days.ago)
book_3 = Book.create(title: "The Princess Bride", pages: 493, year_pub: 1973, image: "https://upload.wikimedia.org/wikipedia/en/c/cf/The_Princess_Bride_%28First_Edition%29.jpg", publisher: "Harcourt Brace Jovanovich", created_at: 4.days.ago, updated_at: 2.days.ago)
book_4 = Book.create(title: "The Shining", pages: 447, year_pub: 1977, image: "https://upload.wikimedia.org/wikipedia/en/4/4c/Shiningnovel.jpg", publisher: "Doubleday", created_at: 3.days.ago, updated_at: 2.days.ago)
book_5 = Book.create(title: "Ruby on Rails", pages: 447, year_pub: 2005, image: "https://i.ebayimg.com/images/g/x1oAAOSwL~FbdPNO/s-l1600.jpg", publisher: "Random House", created_at: 2.days.ago, updated_at: 2.days.ago)

Author.create(books: [book_1, book_2], name: "JK Rowling", age: 53, hometown: "Yate", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/220px-J._K._Rowling_2010.jpg")
Author.create(books: [book_3], name: "William Goldman", age: 87, hometown: "Manhattan, New York", image: "https://upload.wikimedia.org/wikipedia/commons/c/c4/William_Goldman.jpg")
Author.create(books: [book_4, book_1], name: "Stephen King", age: 71, hometown: "Portland, Maine", image: "https://upload.wikimedia.org/wikipedia/commons/e/e3/Stephen_King%2C_Comicon.jpg")
Author.create(books: [book_5], name: "Nerd", age: 26, hometown: "lameville", image: "https://savageminds.org/wp-content/image-upload/600full-revenge-of-the-nerds-screenshot.jpg")
#Author.create(name: "Zach", age: 27, hometown: "Boulder", image: "https://cdn-images-1.medium.com/max/1600/0*xkoslog_JZCZsLgb.jpg")

review_1 = book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
review_2 = book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
review_3 = book_2.reviews.create(title: "So so", score: 3, review_text: "text body")
review_4 = book_4.reviews.create(title: "As Expected", score: 5, review_text: "Love Ruby")

User.create(reviews: [review_1, review_3], name: "April", age: 35, location: "Colorado", image: "")
User.create(reviews: [review_2], name: "Peter", age: 30, location: "Pit of Despair", image: "")
User.create(reviews: [review_4], name: "Julia", age: 28, location: "Colorado", image: "")
User.create(name: "Earl", age: 40, location: "here", image: "")
