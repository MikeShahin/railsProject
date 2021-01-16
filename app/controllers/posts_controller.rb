class PostsController < ApplicationController
    before_action :current_user
    
    def index
        if params[:user_id]
            @posts = User.find(params[user_id]).posts
        else
            @posts = Post.all
        end
    end

    def new
        if !current_user
            redirect_to "/"
        else
            @post = Post.new
        end
    end

    def create
        @post = Post.new(post_params)
        @post.save
        redirect_to post_path(@post)
    end

    def show
        @post = Post.find_by(id: params[:id])
    end

    private
    
    def post_params
        params.require(:post).permit(:title, :url, :description, :user_id)
    end

end
