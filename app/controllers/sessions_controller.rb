class SessionsController < ApplicationController

  def index
    @user = User.find(session[:current_user_id]) if @user
  end

  # def new
  #   @user = User.find(email: params[:email]) #session[:current_user_id]) if session[:current_user_id]
  # end

  def create
    if @user = User.find_by(email: params[:email])
      if @user.authenticate(params[:password])
        session[:current_user_id] = @user.id

        status = {:loginSecure => "True"}

        render :json => status 

      else
        status = {:loginSecure => "False"}

        render :json => status 
      end
    else
      status = {:loginSecure => "False"}

      render :json => status 
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end
