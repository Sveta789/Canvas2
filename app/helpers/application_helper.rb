module ApplicationHelper
  def find_rating arrayOfRatings
    avg = 0;
    if arrayOfRatings.nil? || arrayOfRatings.length == 0
      return avg;
    end
    arrayOfRatings.each { |rating| avg += rating.rating  }
    return (avg/arrayOfRatings.length).round(1)
  end

  def self.get_video_categories
    ['Все','TFP', 'Творческие', 'Свадьбы', 'Праздники', 'Вечеринки', 'Love story', 'Коммерческие', 'Другие']
  end

  def self.get_photo_categories
    ['Все', 'Свадьбы', 'Праздники', 'Love Story', 'Персональные', 'Коммерческие', 'Вечеринки', 'Другие', 'Фотопроекты']
  end

  def youtube_video(id)
    render :partial => 'shared/video', :locals => { :id => id }
  end

end
