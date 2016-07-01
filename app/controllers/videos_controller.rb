class VideosController < ApplicationController
  def destroy
    Video.find(params[:id]).destroy
    redirect_to current_user.portfolio
  end

  def new
    @video = Video.new
  end

  def create
    @video = current_user.videos.build(path: (video_params[:path].sub("watch?v=", "v/")), title: video_params[:title], category: video_params[:category])

    respond_to do |format|
      if @video.save
        format.html { redirect_to current_user.portfolio }
        format.js   {}
        format.json { render json: @video, status: :created, location: @current_user.portfolio }
      else
        format.html { render action: current_user.portfolio }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def video_params
    params.require(:video).permit(:path,:title,:category)
  end
end
