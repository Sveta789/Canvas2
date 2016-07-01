class VideographiesController < ApplicationController
  def index
    @videographies = Videography.all
  end

  def new
    @videography = Videography.new
  end

  def create
    @videography = current_user.videographies.build(videographies_params)    # Not the final implementation!
    if @videography.save
      flash[:success] = "Услуга добавлена!"
      redirect_to :back
    else
      render 'new'
    end
  end

  def videographies_params
    params.require(:videography).permit(:category, :price,
                                     :description)
  end
end
