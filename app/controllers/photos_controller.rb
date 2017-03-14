class PhotosController < ApplicationController

  def destroy
    Photo.find(params[:id]).destroy
    redirect_to :back
  end

  def new
    @photo = Photo.new
    @category = params[:category]
    respond_to do |format|
      format.html { redirect_to photos_path }
      format.js { render 'photos/add_new' }
      format.json { render 'photos/add_new' }
    end
  end


  def create
    @photo = current_user.photos.build(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to current_user.portfolio }
        format.js {}
        format.json { render json: @photo, status: :created, location: @current_user.portfolio }
      else
        format.html { redirect_to current_user.portfolio }
        # format.json { render json: @photo.errors, status: :unprocessable_entity }
        format.json {}
      end
    end
  end


  def upload
    uploaded_io = params[:photo][:image]
    filepath = nil
    File.open(Rails.root.join('public', 'uploads/photo/image', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      filepath = file
    end
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      render json: @photo, status: :created, location: @current_user.portfolio
    else
      render 'static_pages/catalog'
    end
  end


  def photo_params
    params.require(:photo).permit(:image, :image_cache, :category, :title)
  end
end
