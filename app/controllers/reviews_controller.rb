class ReviewsController < ApplicationController
  # def show
  #   @review = Review.find(params[:id])
  # end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    new_params = review_params
    #
    # if params[:review][:image] == ""
    #   new_params.delete("image")
    # end

    username = params[:review][:user]
    user = User.find_or_create_by(name: username.titleize.strip)

    new_params[:user] = user
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(new_params)
    if @review.save
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :score, :review_text, :book_id, :image)
  end
end
