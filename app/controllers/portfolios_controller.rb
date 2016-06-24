class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @photos = User.find(@portfolio.user_id).photos
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @photos = User.find(@portfolio.user_id).photos
    @photo = Photo.new
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


  def port_params
    params.require(:portfolio).permit(:description)
  end


end
