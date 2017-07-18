class RoundsController < ApplicationController

  def new
    @user = current_user
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

  def edit
    @user = current_user
    @round = @user.rounds.find_by_id(params[:id])
  end

  def update
    @user = current_user
    @round = @user.rounds.find_by_id(params[:id])
    if @round.update_attributes(round_params)
      flash[:update] = 'Round Updated!'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    @round = @user.rounds.find_by_id(params[:id])
    @round.destroy
    flash[:purged] = 'Round Deleted!'
    redirect_to @user
  end

  private

  def round_params
    params.require(:round).permit(:club_id, :tee_id, :user_id, :adjusted_score, :date_played)
  end

end
