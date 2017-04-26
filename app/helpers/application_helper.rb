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
    ['TFP', 'Творческие', 'Свадьбы', 'Праздники', 'Вечеринки', 'Love story', 'Коммерческие', 'Другие']
  end

  def self.get_photo_categories
    ['TFP','Fashion','Свадебная','Детская и семейная', 'Праздники', 'Концерты и вечеринки', 'Персональная', 'Love Story', 'Коммерческая','Интерьерная','Предметная','Другие']
  end

  def youtube_video(id)
    render :partial => 'shared/video', :locals => { :id => id }
  end

end
