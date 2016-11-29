module ApplicationHelper
  def find_rating(arrayOfRatings)
    avg = 0;
    if(arrayOfRatings.nil? || arrayOfRatings.length == 0)
      return avg;
    end
    arrayOfRatings.each { |rating| avg += rating.rating  }
    return avg/arrayOfRatings.length
  end
end
