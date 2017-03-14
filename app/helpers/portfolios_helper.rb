module PortfoliosHelper
  def get_background_by_category(kindOf)
    case kindOf
    when 'Свадьбы'
    image_url('Photo_for_filters/1.jpg')
    when 'Праздники'
    image_url('Photo_for_filters/2.jpg')
    when 'Love Story'
    image_url('Photo_for_filters/3.jpg')
    when 'Персональные'
    image_url('Photo_for_filters/4.jpg')
    when 'Коммерческие'
    image_url('Photo_for_filters/5.jpg')
    when 'Вечеринки'
    image_url('Photo_for_filters/6.jpg')
    when 'Другие'
    image_url('Photo_for_filters/7.jpg')
    when 'Фотопроекты'
    image_url('Photo_for_filters/8.jpg')
    end
  end

  def find_rating(arrayOfRatings)
    avg = 0;
    if(arrayOfRatings.nil? || arrayOfRatings.length == 0)
      return '%.1f' % avg;
    end
    arrayOfRatings.each { |rating| avg += rating.rating  }
    return '%.1f' % (avg/arrayOfRatings.length)
  end
end
