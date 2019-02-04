require "rails_helper"

RSpec.describe "review new page", type: :feature do
  before :each do
    @book_1 = Book.create(title: "Harry Potter 1", pages: 303, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_2 = Book.create(title: "Harry Potter 2", pages: 253, year_pub: 1993, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @book_3 = Book.create(title: "The Shining", pages: 2045, year_pub: 1991, image: "https://d3n8a8pro7vhmx.cloudfront.net/sundayassemblyla/pages/2543/attachments/original/1528303608/book.jpg?1528303608", publisher: "Random House")
    @books = [@book_1, @book_2, @book_3]
  end

  it "allows user to create a new book review" do
    title = "Good review"
    score = 4
    review_text = "lots of text"
    user = "Frank"

    visit new_book_review_path(@book_1)

    fill_in :review_title, with: title
    fill_in :review_score, with: score
    fill_in :review_review_text, with: review_text
    fill_in :review_user, with: user

    click_on 'Save'

    expect(current_path).to eq(book_path(@book_1))
    expect(page).to have_content(title)
    expect(page).to have_content("Rating: #{score}")
    expect(page).to have_content(review_text)
    expect(page).to have_content(user)
    expect(page).to_not have_content("good review")
  end

  it "renders new form if fields invalid" do
    visit new_book_review_path(@book_1)

    fill_in "review[title]", with: "bad review"
    fill_in "review[review_text]", with: "more review"
    fill_in :review_user, with: "Frank"

    click_on 'Save'

    expect(page).to have_selector("input[type=submit][value='Save']")
  end

end
