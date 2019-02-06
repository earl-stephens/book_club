class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    new_params = review_params

    username = params[:review][:user]
    user = User.find_or_create_by(name: username.titleize.strip)
    new_params[:user] = user
    new_params[:title] = review_params[:title].titleize

    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(new_params)
    
    if @review.save
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:review])
    @review.destroy
    redirect_to user_path(params[:id]), notice: "Review Deleted"
  end

  private

  def review_params
    params.require(:review).permit(:title, :score, :review_text, :book_id, :image)
  end
end
