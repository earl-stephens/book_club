class BooksController < ApplicationController
  def index
    @books = Book.all
    if params[:sort]
      @books.select_sort(params[:sort][:value])
    end
  end

  def show
    @book = Book.find(params[:id])
  end

end
