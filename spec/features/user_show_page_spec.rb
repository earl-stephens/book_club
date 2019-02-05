require 'rails_helper'

RSpec.describe'user show page', type: :feature do
  before :each do
    @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_4 = Book.create(title: "Ruby on Rails", pages: 1054, year_pub: 2005, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @books = [@book_1, @book_2, @book_3, @book_4]

    @author_1 = Author.create(books: [@book_3], name: "Shakespeare", age: 300, hometown: "London", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Shakespeare.jpg/220px-Shakespeare.jpg")
    @author_2 = Author.create(books: [@book_1, @book_2], name: "JK Rowling", age: 53, hometown: "Yate", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/220px-J._K._Rowling_2010.jpg")
    @author_3 = Author.create(books: [@book_1, @book_3], name: "James Patterson", age: 71, hometown: "Newburgh", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/James_Patterson.jpg/220px-James_Patterson.jpg")
    @author_4 = Author.create(books: [@book_4], name: "Nerd", age: 26, hometown: "lameville", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/James_Patterson.jpg/220px-James_Patterson.jpg")

    @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body", created_at: "2019-01-31 00:00:00")
    #@review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body", created_at: Date.today - 5)
    @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body", created_at: "2019-02-02 00:00:00")
    @review_3 = @book_2.reviews.create(title: "So so", score: 3, review_text: "text body", created_at: "2019-02-01 00:00:00")
    @review_4 = @book_4.reviews.create(title: "As Expected", score: 5, review_text: "Love Ruby", created_at: "2019-01-11 00:00:00")

    @user_1 = User.create(reviews: [@review_1, @review_3], name: "April", age: 35, location: "Paris", image: "https://ae01.alicdn.com/kf/HTB1ebxFSXXXXXcCaXXXq6xXFXXX1/18cm-14-6cm-Interesting-Vinyl-Decal-Karate-Stick-Figure-Man-Ninja-Car-Sticker-Black-Silver-S6.jpg_640x640.jpg")
    @user_2 = User.create(reviews: [@review_2], name: "Peter")
    @user_3 = User.create(reviews: [@review_4], name: "Julia")
    @user_4 = User.create(name: "Earl")
  end

  context "user clicks user link to go to user show page" do
    it "user can see user information" do
      name = "April"
      age = 35
      location = "Paris"
      image = "https://ae01.alicdn.com/kf/HTB1ebxFSXXXXXcCaXXXq6xXFXXX1/18cm-14-6cm-Interesting-Vinyl-Decal-Karate-Stick-Figure-Man-Ninja-Car-Sticker-Black-Silver-S6.jpg_640x640.jpg"

      visit user_path(@user_1)

      expect(page).to have_content(name)
      expect(page).to have_content("Age: #{age}")
      expect(page).to have_content(location)
      expect(page).to have_css("img[src*='#{image}']")
    end

    it "user can see all user reviews" do
      visit user_path(@user_1)

      #@user_1.reviews.each do |review|
        within ".user_review_#{@review_1.id}" do
          image = "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608"
          expect(page).to have_css("img[src*='#{image}']")
          expect(page).to have_content("Harry Potter 1")
          expect(page).to have_content("Good book")
          expect(page).to have_content("Rating: 4")
          expect(page).to have_content("text body")
          expect(page).to have_content("Created on: January 31, 2019")
        end

        within ".user_review_#{@review_3.id}" do
          image = "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608"
          expect(page).to have_css("img[src*='#{image}']")
          expect(page).to have_content("Harry Potter 2")
          expect(page).to have_content("So so")
          expect(page).to have_content("Rating: 3")
          expect(page).to have_content("text body")
          expect(page).to have_content("Created on: February 1, 2019")
        end

    end
  end

end
