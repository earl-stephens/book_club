class BooksController < ApplicationController
  def index
    if params[:sort]
      @books = Book.select_sort(params[:sort][:value])
    else
      @books = Book.all
    end
    @top_books = Book.top_books.limit(3)
    @worst_books = Book.worst_books.limit(3)
    @top_users = []
  end

  def show
    @book = Book.find(params[:id])
    # @top_reviews = Book.top_reviews
  end

  def new
    @book = Book.new
  end

end
