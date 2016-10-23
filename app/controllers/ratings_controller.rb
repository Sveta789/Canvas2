class RatingsController < ApplicationController
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

  def onPluginClick
    vote = current_user.ratings.where("portfolio_id = #{rating_params[:portfolio_id]}")
    if (vote.blank?)
      @rating = current_user.ratings.build(rating_params)
      if @rating.save
        render 'ratings/create'
      else
      end
    else
      vote.update
      if vote.update_attributes(rating_params)
        flash[:success] = "You voted"
        render 'ratings/create'
      else
        render 'ratings/create'
      end
    end

  end

  def show
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :rating, :portfolio_id)
  end
end
