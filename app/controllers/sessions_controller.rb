class SessionsController < ApplicationController
    # skip_before_action :verify_user, only: [:new, :create]
    require 'pry'
    def new
        
    end

    def create
        if @user = User.find_by(name: params[:name])
            session[:user_id] = @user.id
            redirect_to user_path(@user)            
        elsif 
            pp request.env['omniauth.auth']
            session[:name] = request.env['omniauth.auth']['info']['name']
            session[:omniauth_data] = request.env['omniauth.auth']
            redirect_to user_path(@user)
        else
            message = "Retry Login!"
            render 'new'
        end
    end

    def destroy
        session.delete("user_id")
        redirect_to '/signin'
    end
end
