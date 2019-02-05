require 'rails_helper'

RSpec.describe'book show page', type: :feature do
  before :each do
    @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
    @review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
    @review_3 = @book_2.reviews.create(title: "So so", score: 3, review_text: "text body")
    @review_4 = @book_1.reviews.create(title: "Loved it", score: 5, review_text: "my fave")
    @review_5 = @book_1.reviews.create(title: "Ok", score: 3, review_text: "it was ok")
    @review_6 = @book_1.reviews.create(title: "Best ever!", score: 5, review_text: "highly recommended")
    @review_7 = @book_1.reviews.create(title: "It was good", score: 4, review_text: "would read it again")
    @review_8 = @book_1.reviews.create(title: "Not so good", score: 2, review_text: "wouldn't recommend it")
    @review_9 = @book_1.reviews.create(title: "Great!", score: 4, review_text: "new favorite")

    @reviews = [@review_1, @review_2]

    @user_1 = User.create(reviews: [@review_1, @review_3, @review_5], name: "April")
    @user_2 = User.create(reviews: [@review_2, @review_6, @review_8], name: "Peter")
    @user_3 = User.create(reviews: [@review_4], name: "Julia")
    @user_4 = User.create(name: "Earl")
  end

  context "user sees book information" do
    it "user_can_see_a_book_show_page" do

      visit book_path(@book_1)

      expect(page).to have_content(@book_1.title)
      expect(page).to_not have_content(@book_2.title)
      expect(page).to have_content(@book_1.pages)
      expect(page).to_not have_content(@book_3.pages)
      expect(page).to have_content(@book_1.year_pub)
      expect(page).to have_css("img[src*='#{@book_1.image}']")
      expect(page).to have_css("img[src*='#{@book_3.image}']")
    end
  end

  context "user sees book review information" do
    it "user_sees_book_reviews_on_show_page" do

      visit book_path(@book_1)

      @reviews.each do |review|
        within ".review_#{review.id}"
          expect(page).to have_content(review.title)
          expect(page).to_not have_content(@review_3.title)
          expect(page).to have_content(review.score)
          expect(page).to have_content(review.review_text)
          expect(page).to have_content(@review_3.review_text)
      end
    end
  end

  context "user sees a new review button" do
    it "user_can_click_button_for_new_review" do

      visit book_path(@book_1)

      expect(page).to have_link("Add a Review!", href: new_book_review_path(@book_1))

      click_link("Add a Review!")
      expect(current_path).to eq(new_book_review_path(@book_1))
    end
  end


  context "user sees book statistics area" do
    it "shows_the_user_the_book_statistics" do

      visit book_path(@book_1)

      expect(page).to have_content("Book Statistics")
      expect(page).to have_content("Average rating: 3")
    end

    context "in top reviews section" do
      it "has top reviews" do
        visit book_path(@book_1)

        within ".book_#{@book_1.id}_top_reviews" do
          expect(page).to have_content("Top three reviews:")

          within ".book_#{@book_1.id}_top_review_#{@review_6.id}" do
            expect(page).to have_content("Best ever!")
            expect(page).to have_content("Rating: 5")
            expect(page).to have_content("User: Peter")
          end

          within ".book_#{@book_1.id}_top_review_#{@review_4.id}" do
            expect(page).to have_content("Loved it")
            expect(page).to have_content("Rating: 5")
            expect(page).to have_content("User: Julia")
          end

          within ".book_#{@book_1.id}_top_review_#{@review_1.id}" do
            expect(page).to have_content("Good book")
            expect(page).to have_content("Rating: 4")
            expect(page).to have_content("User: April")
          end
        end
      end

      context "in worst reviews section" do
        it "has bottom reviews" do
          visit book_path(@book_1)

          within ".book_#{@book_1.id}_bottom_reviews" do
            expect(page).to have_content("Bottom three reviews:")

            within ".book_#{@book_1.id}_bottom_review_#{@review_2.id}" do
              expect(page).to have_content("Hated it")
              expect(page).to have_content("Rating: 1")
              expect(page).to have_content("User: Peter")
            end

            within ".book_#{@book_1.id}_bottom_review_#{@review_8.id}" do
              expect(page).to have_content("Not so good")
              expect(page).to have_content("Rating: 2")
              expect(page).to have_content("User: Peter")
            end

            within ".book_#{@book_1.id}_bottom_review_#{@review_5.id}" do
              expect(page).to have_content("Ok")
              expect(page).to have_content("Rating: 3")
              expect(page).to have_content("User: April")
            end
          end
        end

        it "has no review statement" do
          visit book_path(@book_3)

          within ".book_stats" do
            expect(page).to_not have_content("Top three reviews:")
            expect(page).to_not have_content("Bottom three reviews:")
            expect(page).to have_content("This book has not yet been reviewed.")
          end
        end
      end
    end
  end

end
