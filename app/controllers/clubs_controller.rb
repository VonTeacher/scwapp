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

  private

  def club_params
    params.require(:club).permit(:name, :city, :state)
  end

end
