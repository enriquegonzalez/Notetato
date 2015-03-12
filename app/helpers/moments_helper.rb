module MomentsHelper
  def mood_average(date)
    mood = Moment.where('date = ?', date)
    return mood.average(:how_do_you_feel)
  end
end
