class ClubsController < ApplicationController

  def index
    @clubs = Club.search(params[:search])
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.create(club_params)
    if @club.valid?
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @club = Club.find_by_id(params[:id])
    if @club.blank?
      render plain: 'Club Not Found', status: :not_found
    end
  end

  def edit
    @club = Club.find_by_id(params[:id])
  end

  def update
    @club = Club.find_by_id(params[:id])
    if @club.update_attributes(club_params)
      flash[:update] = 'Club Updated!'
      redirect_to club_path(@club)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @club = Club.find_by_id(params[:id])
    @club.destroy
    flash[:purged] = 'Club Deleted!'
    redirect_to clubs_path
  end

  private

  def club_params
    params.require(:club).permit(:name, :city, :state)
  end

end
