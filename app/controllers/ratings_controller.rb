class RatingsController < ApplicationController
  include ApplicationHelper

  def new
    @rating = Rating.new
  end

  def create
    @rating = current_user.ratings.build(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to current_user.portfolio }
        format.js   {}
        format.json { render json: @rating, status: :created, location: @current_user.portfolio }
      else
        format.html { render action: current_user.portfolio }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def get_rating_info
    all_ratings = Portfolio.find(asked_rating_params[:portfolio_id]).ratings
    @count_ratings = all_ratings.length
    @average_rating = find_rating(all_ratings)
    @user_rating = "Не голосовал"
    if current_user
      status = current_user.ratings.find_by("portfolio_id = #{asked_rating_params[:portfolio_id]}")
      if !status.blank?
          @user_rating = status.rating
      end
    end
    render 'ratings/answer'
  end

  def onPluginClick
    vote = current_user.ratings.find_by("portfolio_id = #{rating_params[:portfolio_id]}")
    if vote.blank?
      @rating = current_user.ratings.build(rating_params)
      @rating.save
    else
      if vote.update_attributes(rating_params)
        @rating = vote
      end
    end
    @user_rating = @rating.rating
    all_ratings = Portfolio.find(rating_params[:portfolio_id]).ratings
    @count_ratings = all_ratings.length
    @average_rating = find_rating(all_ratings)
    render 'ratings/answer'
  end

  def show
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :rating, :portfolio_id)
  end

  def asked_rating_params
    params.require(:rating).permit(:user_id, :portfolio_id)
  end
end
