class StaticPagesController < ApplicationController
  def index
    @photo_prices = get_min_and_max_price_of_model(Shooting.all)
    @video_prices = get_min_and_max_price_of_model(Videography.all)
    render "static_pages/home"
  end

  def signup
    render "static_pages/signup"
  end

  def catalog
    @result = Shooting.all
    render 'static_pages/catalog'
  end

  def videocatalog
    @result = Videography.all
    render 'static_pages/videocatalog'
  end

  def photofilter
    if filter_params[:category] == 'Все' || filter_params[:category].nil?
    @result = Shooting.where(price: filter_params[:min]..filter_params[:max])
    else
    @result = Shooting.where(price: filter_params[:min]..filter_params[:max], category: filter_params[:category])
    end
    @result.order(:sort_by)
    @old_params = filter_params
    respond_to do |format|

        format.html { render 'static_pages/catalog'}
        format.js   {}
        format.json {}
      end
  end


  def videofilter
    if filter_params[:category] == 'Все' || filter_params[:category].nil?
      @result = Videography.where(price: filter_params[:min]..filter_params[:max])
    else
      @result = Videography.where(price: filter_params[:min]..filter_params[:max], category: filter_params[:category])
    end
    @result.order(:sort_by)
    respond_to do |format|

      format.html { render 'static_pages/videocatalog'}
      format.js   {}
      format.json {}
    end
  end




  def filter_params
    params.require(:filter).permit(:min, :max,
                                     :sort_by, :category)
  end

end
