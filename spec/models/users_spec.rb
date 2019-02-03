require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it {should have_many :reviews}
  end

  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a name' do
        user = User.create(age: 29, location: "Colorado")
        expect(user).to_not be_valid
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

    it 'orders reviewers by count ' do
      users = User.top_reviewers

      expect(users).to eq([@user_1, @user_3, @user_2])
    end
  end

  describe "Instance Methods" do
    before :each do
      @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
      @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
      @user_1 = User.create(reviews: [@review_1, @review_2], name: "April")
    end

    it 'counts reviewers' do
      count = @user_1.number_reviews

      expect(count).to eq(2)
    end
  end
end
