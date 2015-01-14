class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :mood

  # before_filter :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    if cookies[:guest_entry] == "exists"
      @entry = Entry.new
        @entry.how_do_you_feel       = cookies[:how_do_you_feel].to_i
        @entry.what_went_well        = cookies[:what_went_well]
        @entry.what_didnt_go_well    = cookies[:what_didnt_go_well]
        @entry.how_to_make_it_better = cookies[:how_to_make_it_better]
        @entry.focus_on_tomorrow     = cookies[:focus_on_tomorrow]
        @entry.how_do_you_feel_now   = cookies[:how_do_you_feel_now].to_i
        @entry.user_id               = current_user.id
      @entry.save

      delete_guest_entry
    end
    root_path
  end

  def delete_guest_entry
      cookies.delete(:guest_entry)
      cookies.delete(:how_do_you_feel)
      cookies.delete(:what_went_well)
      cookies.delete(:what_didnt_go_well)
      cookies.delete(:how_to_make_it_better)
      cookies.delete(:focus_on_tomorrow)
      cookies.delete(:how_do_you_feel_now)
  end

  def mood(type)
    if type <= 1.5
        "happy"
    elsif type > 1.5 && type <= 2.5
        "pleasant"
    elsif type > 2.5 && type <= 3.5
        "sad"
    elsif type > 3.5 && type <= 4.5
        "angry"
    end
  end

end
