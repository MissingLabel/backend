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

        @loginSecure = "True"

        respond_to do |format|
          format.json { render :json => @loginSecure }
        end
      else
        @loginSecure = "False"

        respond_to do |format|
          format.json { render :json => @loginSecure }
        end
      end
    else
      @loginSecure = "False"
      respond_to do |format|
        format.json { render :json => @loginSecure }
      end
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end
end
