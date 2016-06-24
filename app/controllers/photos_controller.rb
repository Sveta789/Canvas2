class PhotosController < ApplicationController
  def destroy
    Photo.find(params[:id]).destroy
    redirect_to edit_portfolio_path
  end

  def new
    @photo = Photo.new
  end

  def create
  @photo = current_user.photos.build(photo_params)
  puts @photo.inspect
  if @photo.save
    flash[:success] = "Micropost created!"
    redirect_to root_url
  else
    @portfolios = Portfolio.all
    render 'portfolios/index'
  end
end

  def photo_params
    params.require(:photo).permit(:image,:image_cache)
  end
end
