require "rails_helper"

RSpec.describe Book, type: :model do
  describe "relationships" do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
  end

  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a title' do
        book = Book.create(pages: 303, year_pub: 1991)
        expect(book).to_not be_valid
      end
      it 'should be invalid if missing an number of pages' do
        book = Book.create(title: "Harry Potter 1", year_pub: 1991)
        expect(book).to_not be_valid
      end
      it 'should be invalid if missing a year' do
        book = Book.create(title: "Harry Potter 1", pages: 303)
        expect(book).to_not be_valid
      end
    end
  end

  describe 'Class Methods' do
    it 'can sort by number of pages' do
      @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_4 = Book.create(title: "Ruby on Rails", pages: 1045, year_pub: 2005, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      #@books = [@book_1, @book_2, @book_3, @book_4]

      books = Book.select_sort("num_pages_asc").all

      expect(books).to eq([@book_2, @book_1, @book_4, @book_3])
    end
  end

  describe "Instance Methods" do
    it "can find average review score" do
      @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
      @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
      @review_3 = @book_1.reviews.create(title: "Hated it", score: 2, review_text: "text body")

      score = @book_1.avg_score.round(2)

      expect(score).to eq(2.33)
    end
  end

end
