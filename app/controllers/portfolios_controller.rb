class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @photo = Photo.new
    @video = Video.new
    @comment = Comment.new
    @rating = Rating.new
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @photos = User.find(@portfolio.user_id).photos
    @photo = Photo.new
    @comment = Comment.new
    @rating = Rating.new
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
