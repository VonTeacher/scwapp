class ClubsController < ApplicationController
  before_action :require_registered_user, only: [:index, :new, :create, :show, :edit, :update]

  def index
    @clubs = Club.search(params[:search])
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.create(club_params)
    if @club.valid?
      flash[:success] = 'Club successfully added!'
      redirect_to @club
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @club = Club.find_by_id(params[:id])
    if @club.blank?
      redirect_to clubs_path, status: :not_found
    end
  end

  def edit
    @club = Club.find_by_id(params[:id])
    if @club.nil?
      redirect_to clubs_path, status: :not_found
    end
  end

  def update
    @club = Club.find_by_id(params[:id])
    if @club.update_attributes(club_params)
      flash[:update] = "#{@club.name} Updated!"
      redirect_to club_path(@club)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @club = Club.find_by_id(params[:id])
    if @club.nil?
      redirect_to clubs_path, status: :not_found
    end
    @club.destroy
    flash[:purged] = 'Club Deleted!'
    redirect_to clubs_path
  end

  private

  def club_params
    params.require(:club).permit(:name, :city, :state)
  end

  def require_registered_user
    unless logged_in?
      flash[:alert] = 'You must be signed in to view this page'
      redirect_to login_url
    end
  end
end
