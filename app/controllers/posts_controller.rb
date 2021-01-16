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
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.save
        redirect_to root_path
    end

    def show
        @post = Post.find_by(id: params[:id])
    end

    private
    
    def post_params
        params.require(:post).permit(:title, :url, :description, :user_id)
    end

end
