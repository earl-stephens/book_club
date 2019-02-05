require 'rails_helper'

describe "user can delete books" do
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
    @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
    @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
    @review_3 = @book_2.reviews.create(title: "So so", score: 3, review_text: "text body")
    @review_4 = @book_4.reviews.create(title: "As Expected", score: 5, review_text: "Love Ruby")
    @user_1 = User.create(reviews: [@review_1, @review_3], name: "April")
    @user_2 = User.create(reviews: [@review_2], name: "Peter")
    @user_3 = User.create(reviews: [@review_4], name: "Julia")
    @user_4 = User.create(name: "Earl")
  end

  context "user is on the book show page"do
    it "displays a delete button" do
      visit book_path(@book_1)

      click_on "Delete this book."

      expect(current_path).to eq(books_path)
      expect(page).to_not have_content("Harry Potter 1")
    end
  end

end
