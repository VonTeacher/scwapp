class UsersController < ApplicationController

  def index
    @users = User.user_search(params[:user_search])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user.blank?
      flash[:alert] = "No user found"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end

end
