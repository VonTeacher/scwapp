class RoundsController < ApplicationController

  def new
    @user = User.find_by(id: params[:user_id])
    @round = Round.new
  end

  def create
    @user = current_user
    @round = @user.rounds.new(round_params)
    if @round.save!
      flash[:notice] = 'Round Added!'
      redirect_to @round.user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def round_params
    params.require(:round).permit(:club_id, :tee_id, :user_id, :adjusted_score, :date_played)
  end

end
