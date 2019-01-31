class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.create(review_params)
    if @review.save
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :score, :review_text, :book_id)
  end
end
