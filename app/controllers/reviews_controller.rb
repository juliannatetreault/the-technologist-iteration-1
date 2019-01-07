class ReviewsController < ApplicationController
  
    def index 
      if logged_in?
        @reviews = current_user.reviews
      else 
        @reviews = Review.most_recent
      end
    end

    def show
      @review = Review.new 
    end

    def new
      @review = Review.new
    end

    def create
      @review = current_user.reviews.build(review_params)
      if @review.save 
        flash[:success] = "You have successfully created a review!"
        redirect_to review_path
      else 
        flash[:error] = "Oops! To write a review, please log in."
        render :new
      end
    end

    def update
      @review = current_user.review.update(review_params)
      if @review.update
        flash[:success] = "You have successfully updated your review!"
        redirect_to review_path
      else 
        flash[:error] = "Oops! To update a review, please log in."
        render :new
      end
    end

    def destroy
      @review.destroy
      flash[:success] = "You have successfully deleted your review!"
      redirect_to review_path
    end

    private 

    def review_params
        params.require(:review).permit(:title, :content)
    end
end