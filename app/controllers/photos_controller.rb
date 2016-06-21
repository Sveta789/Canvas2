class PhotosController < ApplicationController
  def destroy
    Photo.find(params[:id]).destroy
    redirect_to edit_portfolio_path
  end

  def new
    @photo = Photo.new
  end
end
