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
    before :each do
      @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_4 = Book.create(title: "Ruby on Rails", pages: 1054, year_pub: 2005, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
      @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
      @review_3 = @book_2.reviews.create(title: "So so", score: 3, review_text: "text body")
      @review_4 = @book_4.reviews.create(title: "As Expected", score: 5, review_text: "Love Ruby")
      @user_1 = User.create(reviews: [@review_1, @review_3], name: "April")
      @user_2 = User.create(reviews: [@review_2], name: "Peter")
      @user_3 = User.create(reviews: [@review_4], name: "Julia")
      @user_4 = User.create(name: "Earl")
    end

    context 'it can sort by' do
      it 'average rating ascending' do
        books = Book.select_sort("avg_rating_asc")

        expect(books).to eq([@book_3, @book_1, @book_2, @book_4])
      end

      it 'average rating descending' do
        books = Book.select_sort("avg_rating_desc")

        expect(books).to eq([@book_4, @book_2, @book_1, @book_3])
      end

      it 'number of pages ascending' do
        books = Book.select_sort("num_pages_asc")

        expect(books).to eq([@book_2, @book_1, @book_4, @book_3])
      end

      it 'number of pages descending' do
        books = Book.select_sort("num_pages_desc")

        expect(books).to eq([@book_3, @book_4, @book_1, @book_2])
      end

      it 'number of reviews ascending' do
        books = Book.select_sort("num_reviews_asc")

        expect(books).to eq([@book_3, @book_2, @book_4, @book_1])
      end

      it 'number of reviews descending' do
        books = Book.select_sort("num_reviews_desc")

        expect(books).to eq([@book_1, @book_2, @book_4, @book_3])
      end
    end

    it 'can list top books first' do
      books = Book.top_books

      expect(books).to eq([@book_4, @book_2, @book_1])
    end

    it 'can list worst books first' do
      books = Book.worst_books

      expect(books).to eq([@book_1, @book_2, @book_4])
    end

  end

  describe "Instance Methods" do
    before :each do
      @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_2 = Book.create(title: "Harry Potter 2", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
      @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
      @review_3 = @book_1.reviews.create(title: "Hated it", score: 2, review_text: "text body")
      @user_1 = User.create(reviews: [@review_1, @review_2, @review_3], name: "April")
    end

    it "can find average review score" do
      score = @book_1.avg_score.round(2)

      expect(score).to eq(2.33)

      score = @book_2.avg_score.round(2)

      expect(score).to eq(0)
    end

    it "can find total number of review users" do
      score = @book_1.avg_score.round(2)

      expect(score).to eq(2.33)

      score = @book_2.avg_score.round(2)

      expect(score).to eq(0)
    end

    it "can find list of additional authors" do
      book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      author_1 = Author.create(books: [book_1], name: "JK Rowling", age: 53, hometown: "Yate", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/220px-J._K._Rowling_2010.jpg")
      author_2 = Author.create(books: [book_1], name: "Shakespeare", age: 300, hometown: "London", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Shakespeare.jpg/220px-Shakespeare.jpg")
      author_3 = Author.create(books: [book_1], name: "James Patterson", age: 71, hometown: "Newburgh", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/James_Patterson.jpg/220px-James_Patterson.jpg")

      other_authors = book_1.other_authors(author_1.name)

      expect(other_authors).to eq([author_3, author_2])
    end


  end

end
