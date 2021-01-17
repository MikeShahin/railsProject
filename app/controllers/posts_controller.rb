class PostsController < ApplicationController
    before_action :current_user
    before_action :set_post, only: [:show, :update, :destroy]
    
    def index
        # if params[:user_id]
        #     @posts = User.find(params[user_id]).posts
        # else
        #     @posts = Post.all.order(created_at: :desc)
        # end
        if params[:order] == "Newest Posts"
            @posts = Post.all.order(created_at: :desc)
        elsif params[:order] == "Oldest Posts"
            @posts = Post.all.order(created_at: :asc)
        elsif params[:query] != ""
            @posts = Post.search(params[:query])
            render 'index'
        else
            @posts = Post.all.order(created_at: :desc)
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

        if @post.valid?
            @post.save
            redirect_to post_path(@post)
        else
            render :new
        end
    end

    def show
        # @user = User.find_by(id: session[:user_id])
        @comments = @post.comments
    end

    def edit
        if session[:user_id] != Post.find_by(id: params[:id]).user_id && !admin
            redirect_to '/'
        else
            set_post
        end
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            render 'new'
        end
    end

    def destroy
        @post.destroy
        redirect_to root_path
    end

    private

    def set_post
        @post = Post.find_by(id: params[:id])
    end
    
    def post_params
        params.require(:post).permit(:title, :url, :description, :user_id)
    end

end
