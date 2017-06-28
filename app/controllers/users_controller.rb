class UsersController < ApplicationController

  def index
    @users = User.user_search(params[:user_search])
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.blank?
      flash[:alert] = "No user found"
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to SCWAPP!'
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
