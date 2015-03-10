class ReportsController < ApplicationController

  def index

    if user_signed_in?
      # @weeks_entries = Entry.this_week(current_user).order("date desc")
      # @todays_entry = Entry.today(current_user).last
      # @yesterdays_entry = Entry.yesterday(current_user).last

      # # Mood Shift
      # @avg_start_feeling = @weeks_entries.average(:how_do_you_feel)
      # @avg_end_feeling = @weeks_entries.average(:how_do_you_feel_now)

      # @mood_start = mood(@avg_start_feeling) if !@avg_start_feeling.nil?
      # @mood_end = mood(@avg_end_feeling) if !@avg_end_feeling.nil?
    end

  end

end
