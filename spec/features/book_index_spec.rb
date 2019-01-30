require "rails_helper"

describe "book_index" do
  before :each do
    @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @books = [@book_1, @book_2, @book_3]
  end

  it "user_can_see_all_books" do
    visit "/books"

    expect(page).to have_content("All Books")
    expect(page).to have_content(@book_1.title)
    expect(page).to have_content(@book_1.publisher)
    expect(page).to have_css("img[src*='#{@book_1.image}']")
    expect(page).to have_content("Pages: #{@book_1.pages}")
    expect(page).to have_content("Year: #{@book_1.year_pub}")
    expect(page).to have_content(@book_2.title)
    expect(page).to have_content(@book_2.publisher)
    expect(page).to have_css("img[src*='#{@book_2.image}']")
    expect(page).to have_content("Pages: #{@book_2.pages}")
    expect(page).to have_content("Year: #{@book_2.year_pub}")
    expect(page).to have_content(@book_3.title)
    expect(page).to have_content(@book_3.publisher)
    expect(page).to have_css("img[src*='#{@book_3.image}']")
    expect(page).to have_content("Pages: #{@book_3.pages}")
    expect(page).to have_content("Year: #{@book_3.year_pub}")
  end

  it "user_sees_review_statistics" do
    review_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")
    review_2 = @book_1.reviews.create(title: "Hated it", score: 1, review_text: "text body")
    review_3 = @book_2.reviews.create(title: "So so", score: 3, review_text: "text body")

    visit '/books'

    expect(page).to have_content("Average Score: 2.5")
    expect(page).to have_content("All Reviews:")
    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.review_text)
    expect(page).to have_content("Score: #{review_1.score}")
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.review_text)
    expect(page).to have_content("Score: #{review_2.score}")
    expect(page).to have_content(review_3.title)
    expect(page).to have_content(review_3.review_text)
    expect(page).to have_content("Score: #{review_3.score}")
  end

  it "user_can_see_all_authors" do
    author_1 = @book_1.reviews.create(title: "Good book", score: 4, review_text: "text body")

    visit "/books"

    expect(page).to have_content(@book_1.author)
    expect(page).to have_content(@book_2.author)
    expect(page).to have_content(@book_3.author)
  end
end
