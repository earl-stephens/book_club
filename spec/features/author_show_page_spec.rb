require 'rails_helper'

RSpec.describe'author show page', type: :feature do
  before :each do
    @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")

    @author_1 = Author.create(books: [@book_1, @book_2], name: "JK Rowling", age: 53, hometown: "Yate", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/220px-J._K._Rowling_2010.jpg")
    @author_2 = Author.create(books: [@book_1, @book_3], name: "Shakespeare", age: 300, hometown: "London", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Shakespeare.jpg/220px-Shakespeare.jpg")
    @author_3 = Author.create(books: [@book_1], name: "James Patterson", age: 71, hometown: "Newburgh", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/James_Patterson.jpg/220px-James_Patterson.jpg")

    @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
    @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body2")
    @review_3 = @book_1.reviews.create(title: "Favorite", score: 5, review_text: "text body3")
    @review_4 = @book_2.reviews.create(title: "So so", score: 3, review_text: "text body")
    @user_1 = User.create(reviews: [@review_1, @review_2, @review_3, @review_4], name: "Earl")

  end

  context "user clicks author link" do
    it "user can see author information" do
      name = "JK Rowling"
      age = 53
      hometown = "Yate"
      image = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/220px-J._K._Rowling_2010.jpg"

      visit author_path(@author_1)

      expect(page).to have_content(name)
      expect(page).to have_content("Age: #{age}")
      expect(page).to have_content(hometown)
      expect(page).to have_css("img[src*='#{image}']")
    end

    it "user can see author book information" do
      visit author_path(@author_1)

      expect(page).to have_content("Harry Potter 1")
      expect(page).to have_content("Year: 1991")
      expect(page).to have_content("Pages: 303")
      expect(page).to have_content("Additional authors: James Patterson Shakespeare")

      expect(page).to have_content("Harry Potter 2")
      expect(page).to have_content("Year: 1993")
      expect(page).to have_content("Pages: 253")

      expect(page).to_not have_content("The Shining")
    end

    it "user can see top review for each book" do
      visit author_path(@author_1)

      within ".author_book_#{@book_1.id}_review" do
        expect(page).to have_content("Favorite")
        expect(page).to have_content("Rating: #{5}")
        expect(page).to have_content("text body3")
        expect(page).to have_content("User: Earl")
      end

      within ".author_book_#{@book_2.id}_review" do

        expect(page).to have_content("So so")
        expect(page).to have_content("Rating: #{3}")
        expect(page).to have_content("text body")
        expect(page).to have_content("User: Earl")
      end

    end
  end

end
