class StaticPagesController < ApplicationController
  def index
    render "static_pages/home"
  end

  def signup
    render "static_pages/signup"
  end

  def catalog
    @result = Shooting.all
    render 'static_pages/catalog'
  end

  def filter
    @result = Shooting.where(price: filter_params[:min]..filter_params[:max], category: filter_params[:category])
    @result.order(:sort_by)
    render 'static_pages/catalog'
  end

  def filter
    @result = Shooting.where(price: filter_params[:min]..filter_params[:max], category: filter_params[:category])
    @result.order(:sort_by)
    respond_to do |format|

        format.html { render 'static_pages/catalog'}
        format.js   {}
        format.json {}
      end
  end




  def filter_params
    params.require(:filter).permit(:min, :max,
                                     :sort_by, :category)
  end

end
