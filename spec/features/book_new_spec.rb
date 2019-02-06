require 'rails_helper'

RSpec.describe "book new page", type: :feature do
  describe "new form" do
    it "shows the user an input form for a new book" do
      title = "The Testaments"
      year_pub = 2019
      pages = 320
      authors = "Margaret Atwood, Stephen King"

      visit new_book_path

      fill_in :book_title, with: title
      fill_in :book_pages, with: pages
      fill_in :book_year_pub, with: year_pub
      fill_in :book_image, with: nil
      fill_in :book_authors, with: authors

      click_on 'Save'

      expect(current_path).to eq(book_path(Book.last))
      expect(page).to have_content(title)
      expect(page).to have_content(pages)
      expect(page).to have_content(year_pub)
      expect(page).to have_content("Margaret Atwood")
    end

    it "renders new form if fields invalid" do
      title = "The Testaments"
      year_pub = 2019
      pages = 320
      authors = "Margaret Atwood, Stephen King"

      visit new_book_path

      fill_in :book_pages, with: pages
      fill_in :book_year_pub, with: year_pub
      fill_in :book_authors, with: authors

      click_on 'Save'

      expect(page).to have_selector("input[type=submit][value='Save']")
    end
  end
end
