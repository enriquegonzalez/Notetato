class ReportsController < ApplicationController

  def index

    if user_signed_in?
      @entries = Entry.last_five_days(current_user).order("date desc")

      # Mood Shift
      @avg_start_feeling = @entries.average(:how_do_you_feel)
      @avg_end_feeling = @entries.average(:how_do_you_feel_now)
      @mood_start = mood(@avg_start_feeling)
      @mood_end = mood(@avg_end_feeling)
    end

  end

end
