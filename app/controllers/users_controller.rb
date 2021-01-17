class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.valid?
            @user.save
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        @posts = Post.where(user_id: @user.id)
    end

    def index
        @users = User.all
        @user = current_user
    end

    def edit
        @user = User.find_by(id: params[:id])
        if !verify_user
            redirect_to '/'
        end
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            redirect_to post_path(@user)
        else
            render 'new'
        end
    end
    
    private
    
    def verify_user
        session[:user_id] == @user.id
    end

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

end
