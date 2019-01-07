class CommentsController < ApplicationController

    def new 
      @review = Review.find(params[:review_id])
      @comment = Comment.new
    end 

    def create
      @review = Review.find(params[:review_id])
      @comment = @review.comments.build(comment_params)
      if @comment.save 
        flash[:success] = "You have successfully created a comment!"
        redirect_to review_comment_path(@review, @comment)
      else 
        render :'reviews/show'
      end
    end

    private 

    def comment_params
      params.require(:comment).permit(:content)
    end
end