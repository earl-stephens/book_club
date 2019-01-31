require "rails_helper"

describe "navbar" do
  it "user_can_click_home_button" do
    visit books_path

    click_link("Home")
    expect(current_path).to eq(root_path)
  end

  it "user_can_click_library_button" do
    visit books_path
    
    click_link("Library")
    expect(current_path).to eq(books_path)
  end

end
