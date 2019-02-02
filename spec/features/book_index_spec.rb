require "rails_helper"

describe "book_index" do
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
    @user_1 = User.create(reviews: [@review_1, @review_3], name: "April")
    @user_2 = User.create(reviews: @review_2, name: "Peter")
    @user_3 = User.create(reviews: @review_4, name: "Julia")
    @user_4 = User.create(name: "Earl")
  end

  it "user_can_see_all_books" do
    visit books_path

    expect(page).to have_content("All Books")

    @books.each do |book|
      within ".book_#{book.id}"
        expect(page).to have_content(book.title)
        expect(page).to have_content(book.publisher)
        expect(page).to have_css("img[src*='#{book.image}']")
        expect(page).to have_content("Pages: #{book.pages}")
        expect(page).to have_content("Year: #{book.year_pub}")
      end
    end

    context "index_statistics" do
      it "user_can_see_three_highest_rated_books" do
        visit books_path

        within ".statistics_top_books" do
          expect(page).to have_content("Recommended Selections:")
          expect(page).to have_content("Ruby on Rails")
          expect(page).to have_content("Harry Potter 2")
          expect(page).to have_content("Harry Potter 1")
        end
      end

      it "user_can_see_three_worst_rated_books" do
        visit books_path

        within ".statistics_worst_books" do
          expect(page).to have_content("Readers Hated:")
          expect(page).to have_content("Ruby on Rails")
          expect(page).to have_content("Harry Potter 2")
          expect(page).to have_content("Harry Potter 1")
        end
      end

      it "user_can_see_three_users_with_most_reviews" do
        visit books_path

        within ".statistics_top_reviewers" do
          expect(page).to have_content("People with too much free time:")
          expect(page).to have_content("April")
          expect(page).to have_content("Julia")
          expect(page).to have_content("Peter")
        end
      end
    end


  context "for each book" do
    it "user_sees_review_statistics" do

      visit books_path

      @books.each do |book|
        within ".book_#{book.id}" do
          expect(page).to have_content("All Reviews:")

          book.reviews.each do |review|
            within ".review_#{review.id}" do
              expect(page).to have_content(review.title)
              expect(page).to have_content(review.review_text)
              expect(page).to have_content("Score: #{review.score}")
            end
          end
        end
      end
    end

    it "user_can_see_all_authors" do
      visit books_path

      @books.each do |book|
        within ".book_#{book.id}" do
          book.authors.each do |author|
            expect(page).to have_content(author.name)
          end
        end
      end
    end

    it "user_can_see_review_statistics" do
      visit books_path

      @books.each do |book|
        within ".book_#{book.id}" do
          if book.reviews.count == 0
            expect(page).to have_content("Average Score: No reviews for this book yet.")
          else
            expect(page).to have_content("Average Score: #{book.avg_score}")
          end
        expect(page).to have_content("Number of Reviews: #{book.reviews.count}")
        end
      end
    end
  end

  context "user selects sort by average rating ascending" do
    it "user can see book list sorted by average rating ascending" do
      visit books_path

      expect(page).to have_content("Sort Results by:")

      select "Average rating (ascending)", :from => "sort[value]"
      click_button("Sort")

      expect(page.all('.book-title')[0]).to have_content('The Shining')
      expect(page.all('.book-title')[1]).to have_content('Harry Potter 1')
      expect(page.all('.book-title')[2]).to have_content('Harry Potter 2')
      expect(page.all('.book-title')[3]).to have_content('Ruby on Rails')
    end
  end

  context "user selects sort by average rating descending" do
    it "user can see book list sorted by average rating descending" do
      visit books_path

      select "Average rating (descending)", :from => "sort[value]"
      click_button("Sort")

      expect(page.all('.book-title')[0]).to have_content('Ruby on Rails')
      expect(page.all('.book-title')[1]).to have_content('Harry Potter 2')
      expect(page.all('.book-title')[2]).to have_content('Harry Potter 1')
      expect(page.all('.book-title')[3]).to have_content('The Shining')
    end
  end

  context "user selects sort by number pages ascending" do
    it "user can see book list sorted by number pages ascending" do
      visit books_path

      select "Number of pages (ascending)", :from => "sort[value]"
      click_button("Sort")

      expect(page.all('.book-title')[0]).to have_content('Harry Potter 2')
      expect(page.all('.book-title')[1]).to have_content('Harry Potter 1')
      expect(page.all('.book-title')[2]).to have_content('Ruby on Rails')
      expect(page.all('.book-title')[3]).to have_content('The Shining')
    end
  end

  context "user selects sort by number pages descending" do
    it "user can see book list sorted by number pages descending" do
      visit books_path

      select "Number of pages (descending)", :from => "sort[value]"
      click_button("Sort")

      expect(page.all('.book-title')[3]).to have_content('Harry Potter 2')
      expect(page.all('.book-title')[2]).to have_content('Harry Potter 1')
      expect(page.all('.book-title')[1]).to have_content('Ruby on Rails')
      expect(page.all('.book-title')[0]).to have_content('The Shining')
    end
  end

  context "user selects sort by number of reviews ascending" do
    it "user can see book list sorted by number of reviews ascending" do
      visit books_path

      select "Number of reviews (ascending)", :from => "sort[value]"
      click_button("Sort")

      expect(page.all('.book-title')[0]).to have_content('The Shining')
      expect(page.all('.book-title')[1]).to have_content('Harry Potter 2')
      expect(page.all('.book-title')[2]).to have_content('Ruby on Rails')
      expect(page.all('.book-title')[3]).to have_content('Harry Potter 1')
    end
  end

  context "user selects sort by number of reviews descending" do
    it "user can see book list sorted by number of reviews descending" do
      visit books_path

      select "Number of reviews (descending)", :from => "sort[value]"
      click_button("Sort")

      expect(page.all('.book-title')[0]).to have_content('Harry Potter 1')
      expect(page.all('.book-title')[1]).to have_content('Harry Potter 2')
      expect(page.all('.book-title')[2]).to have_content('Ruby on Rails')
      expect(page.all('.book-title')[3]).to have_content('The Shining')
    end
  end

end
