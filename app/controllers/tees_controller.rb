class TeesController < ApplicationController

  def new
    @club = Club.find(params[:club_id])
    @tee = Tee.new
  end

  def create
    @club = Club.find(params[:club_id])
    @tee  = @club.tees.create(tee_params)
    if @tee.valid?
      redirect_to club_path(@club)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @club = Club.find(params[:club_id])
    @tee  = @club.tees.find_by_id(params[:id])
  end

  def update
    @club = Club.find(params[:club_id])
    @tee  = @club.tees.find_by_id(params[:id])
    if @tee.update_attributes(tee_params)
      flash[:update] = "#{@tee.color} Tee Updated!"
      redirect_to @club
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @club = Club.find(params[:club_id])
    @tee  = @club.tees.find_by_id(params[:id])
    if @tee.nil?
      redirect_to @club, status: :not_found
    end
    @tee.destroy
    flash[:purged] = 'Tee Deleted!'
    redirect_to @club
  end

  private

  def tee_params
    params.require(:tee).permit(:color, :usga_course_rating_18, :slope_rating_18, :front_9_rating, :front_9_slope, :back_9_rating, :back_9_slope, :bogey_rating, :gender, :club_id)
  end

end
