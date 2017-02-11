class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @photo = Photo.new
    @video = Video.new
    @comment = Comment.new
    if current_user
    @hasVoted = @portfolio.ratings.where("user_id = #{current_user.id}").any?
    if(@hasVoted)
      @rating = current_user.ratings.find_by("portfolio_id = #{@portfolio.id}");
    else
      @rating = Rating.new
    end
    end
    @edit_mode = false;
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @photo = Photo.new
    @video = Video.new
    @comment = Comment.new
    if current_user
      @hasVoted = @portfolio.ratings.where("user_id = #{current_user.id}").any?
      if(@hasVoted)
        @rating = current_user.ratings.find_by("portfolio_id = #{@portfolio.id}");
      else
        @rating = Rating.new
      end
    end
    @edit_mode = true;
    render 'portfolios/show'
  end

  def update
    def update
      @portfolio = Portfolio.find(params[:id])
      if @portfolio.update_attributes(port_params)
        # Handle a successful update.
        flash[:success] = "Profile updated"
        redirect_to @portfolio
      else
        render 'edit'
      end
    end
  end

  def new_shooting
    @shooting = Shooting.new(params_for_shooting)
    render 'shootings/new'
  end


  def port_params
    params.require(:portfolio).permit(:description)
  end

  def params_for_shooting
    params.permit(:category)
  end


end
