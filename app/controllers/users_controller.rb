class UsersController < ApplicationController
  include UsersHelper

  before_action :require_registered_user, only: [:index, :show, :edit, :update]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile successfully updated!'
      redirect_to @user
    else
      flash[:alert] = "Save was unsuccessful"
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def require_registered_user
      unless logged_in?
        flash[:alert] = 'You must be signed in to view this page'
        redirect_to login_url
      end
    end
end
