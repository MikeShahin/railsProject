class CommentsController < ApplicationController
    def new
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(parent_id: params[:parent_id])
      end

    def create
      @comment = Comment.new(comment_params)
      if @comment.valid?
        @comment.save
        redirect_to post_path(@post.id)
      else
        render :new
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:reply, :user_id, :post_id)
    end

end
