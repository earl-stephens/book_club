require "rails_helper"

describe "splash_page" do
  it "user_sees_splash_page" do
    image = "https://martijnscheijbeler.com/wp-content/uploads/2018/01/books.jpg"
    visit root_path

    expect(page).to have_content("Welcome")
    expect(page).to have_content("Feel free to browse our library of books")
    expect(page).to have_css("img[src*='#{image}']")
  end
end
