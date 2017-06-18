class TeesController < ApplicationController

  def new
    @tee = Tee.new
  end

  def create
    @tee = Tee.create(tee_params)
    if @tee.valid?
      redirect_to tees_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def tee_params
    params.require(:tee).permit(:color, :usga_course_rating_18, :slope_rating_18, :front_9_rating, :front_9_slope, :back_9_rating, :back_9_slope, :bogey_rating, :gender, :club_id)
  end

end
