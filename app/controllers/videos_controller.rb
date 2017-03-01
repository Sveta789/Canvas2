class VideosController < ApplicationController
  def destroy
    Video.find(params[:id]).destroy
    redirect_to current_user.portfolio
  end

  def new
    @video = Video.new
    @category = params[:category]
    respond_to do |format|
      format.html {redirect_to videos_path}
      format.js{ render 'videos/add_new'}
      format.json { render 'videos/add_new'}
    end
  end

  def create
    @video = current_user.videos.build(path: YouTubeAddy.extract_video_id(video_params[:path]), title: video_params[:title], category: video_params[:category])

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
