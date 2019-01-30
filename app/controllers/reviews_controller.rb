class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new

  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to "/reviews/#{@review.id}"
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :score, :review_text, :book_id)
  end
end
