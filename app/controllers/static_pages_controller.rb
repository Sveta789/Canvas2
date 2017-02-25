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
      @categories = ApplicationHelper.get_photo_categories
      @hidden_area = "Фотосъемка"
      @prices = get_min_and_max_price_of_model(Shooting.all)
    else
      order = getOrderSymbol(filter_params[:sort_by])
      if filter_params[:area] == "Фотосъемка"
        @result = Shooting.filter(filter_params.slice(:author_name, :category, :price)).order(order)
        @categories = ApplicationHelper.get_photo_categories
        @hidden_area = "Фотосъемка"
        @prices = get_min_and_max_price_of_model(Shooting.all)
      else
        @result = Videography.filter(filter_params.slice(:author_name, :category, :price)).order(order)
        @categories = ApplicationHelper.get_video_categories
        @hidden_area = "Видеосъемка"
        @prices = get_min_and_max_price_of_model(Videography.all)
      end
      @old_params = filter_params
    end

    respond_to do |format|
      format.html { render 'static_pages/catalog' }
      format.js { render 'catalog_refresh' }
      format.json { render 'catalog_refresh' }
    end
  end


  def filter_params
    price_params = (params[:filter] || {})[:price].keys
    params.require(:filter).permit(:sort_by, :category, :area, :author_name, price: price_params)
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
