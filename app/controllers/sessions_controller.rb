class SessionsController < ApplicationController
    # skip_before_action :verify_user, only: [:new, :create]
    require 'pry'
    def new
        
    end

    def create
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)            
        else
            render 'new', {alert: "Your Username or Password was invalid"}
        end
    end

    def github
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
        #   u.name = auth['info']['name']
        #   u.email = auth['info']['email']
        end
        binding.pry
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    def destroy
        session.delete("user_id")
        redirect_to '/signin'
    end
end

private

  def auth
    request.env['omniauth.auth']
  end