class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(user_params)
    # raise params[:user].inspect
    @user = User.new(user_params)

    if @user.save
      # flash[:notice] = "You have successfully signed up!"
      session[:current_user_id] = @user.id
      redirect_to '/'
    else
      @user.errors
      render new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit( :email, :password, :zip_code)
  end

end
