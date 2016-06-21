class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    photos_array = Photo.all
    @photos = []
    photos_array.each do |photo|
       if photo.user_id == @portfolio.user_id
         @photos << photo
      end
    end
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @photo = Photo.new
    photos_array = Photo.all
    @photos = []

    photos_array.each do |photo|
      if photo.user_id == @portfolio.user_id
        @photos << photo
      end
    end
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
