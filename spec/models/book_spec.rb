require "rails_helper"

RSpec.describe Book, type: :model do
  describe "relationships" do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
  end

  describe 'Validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a title' do
        book = Book.create(pages: 303, year_pub: 1991)
        expect(book).to_not be_valid
      end
      it 'should be invalid if missing an number of pages' do
        book = Book.create(title: "Harry Potter 1", year_pub: 1991)
        expect(book).to_not be_valid
      end
      it 'should be invalid if missing a year' do
        book = Book.create(title: "Harry Potter 1", pages: 303)
        expect(book).to_not be_valid
      end
    end
  end
end
