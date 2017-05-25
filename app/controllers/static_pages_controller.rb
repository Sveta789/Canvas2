class StaticPagesController < ApplicationController
  include ApplicationHelper

  layout :resolve_layout
  layout "application", except: [:index, :about]
  layout "main_page", only: [:index]
  layout "layout-no-footer", only: [:about]



  def index
    @photo_prices = get_min_and_max_price_of_model(Shooting.all)
    @video_prices = get_min_and_max_price_of_model(Videography.all)
    render "static_pages/home", layout: "main_page"
  end

  def signup
    set_meta_tags title: 'Регистрация',
                  description: 'Страница для регистрации.',
                  keywords: 'Site, Login, Members, Инструкции, Фото, Видео'
    render "static_pages/signup"
  end

  def about
    set_meta_tags title: 'О нас',
                  description: 'Стартовая страница с инструкциями.',
                  keywords: 'Site, Login, Members, Инструкции, Фото, Видео'
    render "static_pages/about"
  end

  def catalog

    if request.params.blank?
      @result = Shooting.all
      @categories = ApplicationHelper.get_photo_categories
      @hidden_area = "Фотосъемка"
      @prices = get_min_and_max_price_of_model(Shooting.all)
    else
      order = getOrderSymbol(filter_params[:sort_by])
      if filter_params[:area] == "Фотосъемка"
        @result = Shooting.filter(filter_params.slice(:author_name, :category, :price))
        @result = @result.filter({:sort_it => order});
        @categories = ApplicationHelper.get_photo_categories
        @hidden_area = "Фотосъемка"
        @prices = get_min_and_max_price_of_model(Shooting.all)
      else
        @result = Videography.filter(filter_params.slice(:author_name, :category, :price))
        @categories = ApplicationHelper.get_video_categories
        @hidden_area = "Видеосъемка"
        @prices = get_min_and_max_price_of_model(Videography.all)
      end
      @old_params = filter_params
    end

    @metatitle = "Каталог/#{filter_params[:category]} - Canvas";

    set_meta_tags title: 'Каталог/' + filter_params[:category],
                  description: 'Каталог фото-видео работ',
                  keywords: 'Site, Login, Members, Инструкции, Фото, Видео'

    respond_to do |format|
      format.html { render 'static_pages/catalog' }
      format.js { render 'catalog_refresh' }
      format.json { render 'catalog_refresh' }
    end
  end

  def greetings
    set_meta_tags title: 'Добро Пожаловать!',
                  description: 'Ожидание подтверждения регистрации',
                  keywords: 'Site, Login, Members, Инструкции, Фото, Видео'
    render "static_pages/greeting"
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
      when 'Популярность'
        return :popularity
      else
        return :price
    end
  end

  def resolve_layout
    case action_name
      when "about"
        "layout-no-footer"
      when "index"
        "main_page"
      else
        "application"
    end
  end
end
