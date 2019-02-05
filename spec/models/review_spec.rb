require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "relationships" do
    it {should belong_to :book}
    it {should belong_to :user}
  end

  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a title' do
        review = Review.create(score: 4, review_text: "text body")
        expect(review).to_not be_valid
      end
      it 'should be invalid if missing a score' do
        review = Review.create(title: "Harry Potter 1", review_text: "text body")
        expect(review).to_not be_valid
      end
      it 'should be invalid if missing review text' do
        review = Review.create(title: "Harry Potter 1", score: 3)
        expect(review).to_not be_valid
      end
    end
  end

  describe 'Class Methods' do
    before :each do
      @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @book_4 = Book.create(title: "Ruby on Rails", pages: 1054, year_pub: 2005, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
      @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body", created_at: "2019-01-31 00:00:00")
      @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body", created_at: "2019-02-02 00:00:00")
      @review_3 = @book_2.reviews.create(title: "So so", score: 3, review_text: "text body", created_at: "2019-02-01 00:00:00")
      @review_4 = @book_4.reviews.create(title: "As Expected", score: 5, review_text: "Love Ruby", created_at: "2019-01-11 00:00:00")
      @review_5 = @book_1.reviews.create(title: "Still Hated it", score: 1, review_text: "text body", created_at: "2019-02-05 00:00:00")
      @user_1 = User.create(reviews: [@review_1, @review_3], name: "April")
      @user_2 = User.create(reviews: [@review_2], name: "Peter")
      @user_3 = User.create(reviews: [@review_5, @review_4], name: "Julia")
      @user_4 = User.create(name: "Earl")
    end

    context 'it can sort by' do
      it 'date descending' do
        reviews = Review.select_sort("newest_first")
        expect(reviews).to eq([@review_5, @review_2, @review_3, @review_1, @review_4])
      end

      it 'date ascending' do
        reviews = Review.select_sort("oldest_first")

        expect(reviews).to eq([@review_4, @review_1, @review_3, @review_2, @review_5])
      end
    end
  end
end
