class PhotosController < ApplicationController
  def destroy
    Photo.find(params[:id]).destroy
    redirect_to current_user.portfolio
  end

  def new
    @photo = Photo.new
  end


  def create
    @photo = current_user.photos.build(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to current_user.portfolio }
        format.js   {}
        format.json { render json: @photo, status: :created, location: @current_user.portfolio }
      else
        format.html { render action: current_user.portfolio }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def photo_params
    params.require(:photo).permit(:image,:image_cache,:category,:title)
  end
end
