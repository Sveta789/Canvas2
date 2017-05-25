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
    ['Клипы', 'Творческие', 'Свадьбы', 'Праздники', 'Вечеринки', 'Love story', 'Коммерческие', 'Другие', 'Motion Design']
  end

  def self.get_photo_categories
    ['TFP','Fashion','Свадебная','Детская и семейная', 'Праздники', 'Концерты и вечеринки', 'Персональная', 'Love Story', 'Коммерческая','Интерьерная','Предметная','Другие']
  end

  def youtube_video(id)
    render :partial => 'shared/video', :locals => { :id => id }
  end

  def default_meta_tags
    {
        reverse: true,
        site: 'Canvas',
        title:       'Home',
        description: 'Site for customers and operators.',
        keywords:    'Site, Login, Members, Video, Photo',
        separator:   "&mdash;".html_safe,
    }
  end

end
