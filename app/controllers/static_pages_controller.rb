class StaticPagesController < ApplicationController

  layout "application", except: [:index]
  layout "main_page", only: [:index]
  include ApplicationHelper

  def index
    @photo_prices = get_min_and_max_price_of_model(Shooting.all)
    @video_prices = get_min_and_max_price_of_model(Videography.all)
    render "static_pages/home"
  end

  def signup
    render "static_pages/signup"
  end

  def about
    render "static_pages/about"
  end

  def catalog
    if request.get?
      @result = Shooting.all
      @categories = getPhotoCats
      @hidden_area = "Видеосъемка"
    else
      cur_cat = (filter_params[:category].nil? || filter_params[:category] == 'Все') ? nil : cur_cat
      author_name = (filter_params[:author_name].nil? || filter_params[:author_name] == '') ? nil : filter_params[:author_name]
      area = nil
      order = getOrderSymbol(filter_params[:sort_by])
      if filter_params[:area].nil? || filter_params[:area] == "Фотосъемка"
        area = Shooting
        @categories = getPhotoCats
        @hidden_area = "Видеосъемка"
      else
        area = Videography
        @categories = getVideoCats
        @hidden_area = "Фотосъемка"
      end

      if cur_cat == nil
        @result = area.where(price: filter_params[:min]..filter_params[:max]).order(order)
      else
        @result = area.where(price: filter_params[:min]..filter_params[:max], category: filter_params[:category]).order(order)
      end
      @old_params = filter_params
    end
    respond_to do |format|

      format.html { render 'static_pages/catalog' }
      format.js { render 'catalog_refresh' }
      format.json { render 'catalog_refresh' }
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

      format.html { render 'static_pages/videocatalog' }
      format.js {}
      format.json {}
    end
  end


  def filter_params
    params.require(:filter).permit(:min, :max, :sort_by, :category, :area)
  end

  private

  def prepareFilterData


  end

  def getOrderSymbol(order_cat)
    case order_cat
    when 'Цена'
      return :price
    when 'Категория'
        return :category
    else
        return :price
    end
  end
end
