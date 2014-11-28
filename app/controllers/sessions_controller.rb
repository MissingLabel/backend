class SessionsController < ApplicationController

  def index
    @user = User.find(session[:current_user_id]) if @user
  end

  def new
    @user = User.find(session[:current_user_id])
  end

  def create
    if @user = User.find_by(email: params[:user][:email])
      if @user.authenticate(params[:user][:password])
        session[:current_user_id] = @user.id
        redirect_to '/'
      else
        # flash.now[:notice] = "Invalid email or password."
        render '/sessions/new'
      end
    else
      # flash.now[:notice] = "Invalid email or password."
      render '/sessions/new'
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end
