module ReportsHelper
  def mood_shift(feeling_start,feeling_end)
    if feeling_start < feeling_end
      "Oh yeah! Your mood is getting better"
    elsif feeling_start == feeling_end && mood(feeling_end) == "happy"
      "You're a happy camper"
    elsif feeling_start == feeling_end
      "Your mood is staying samesies"
    else
      "Uh oh! Your mood is worse"
    end
  end
end
