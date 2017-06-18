class ClubsController < ApplicationController

  def index
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

  private

  def club_params
    params.require(:club).permit(:name, :city, :state)
  end

end
