require "rails_helper"

describe "book_index" do
  it "user_can_see_all_book" do
    book_1 = Book.create(title: "Harry Potter 1", author: "J.K. Rowling", pages: 303, year_pub: 1991)
    book_2 = Book.create(title: "Harry Potter 2", author: "J.K. Rowling", pages: 253, year_pub: 1993)
    book_3 = Book.create(title: "The Shining", author: "Stephen King", pages: 2045, year_pub: 1991)

    visit "/books"

    expect(page).to have_content("All Books")
    expect(page).to have_content(book_1.title)
    expect(page).to have_content(book_1.author)
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year: #{book_1.year_pub}")
    expect(page).to have_content(book_2.title)
    expect(page).to have_content(book_2.author)
    expect(page).to have_content("Pages: #{book_2.pages}")
    expect(page).to have_content("Year: #{book_2.year_pub}")
    expect(page).to have_content(book_3.title)
    expect(page).to have_content(book_3.author)
    expect(page).to have_content("Pages: #{book_3.pages}")
    expect(page).to have_content("Year: #{book_3.year_pub}")
  end
end
