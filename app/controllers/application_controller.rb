class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :mood, :cryptor

  around_filter :user_time_zone, if: :current_user

  def after_sign_in_path_for(resource_or_scope)
    if cookies[:guest_moment] == "exists"
      @moment = Moment.new
        @moment.how_do_you_feel       = cookies[:how_do_you_feel].to_i
        @moment.why                   = cookies[:why]
        @moment.what_went_well        = cookies[:what_went_well]
        # @moment.focus_on_tomorrow     = cookies[:focus_on_tomorrow]
        # @moment.how_do_you_feel_now   = cookies[:how_do_you_feel_now].to_i
        @moment.user_id               = current_user.id
        @moment.date                  = Date.current.in_time_zone(current_user.time_zone)
      @moment.save

      delete_guest_moment
    end
    moment_path(@moment)
  end

  def delete_guest_moment
      cookies.delete(:guest_moment)
      cookies.delete(:how_do_you_feel)
      cookies.delete(:why)
      cookies.delete(:what_went_well)
      # cookies.delete(:focus_on_tomorrow)
      # cookies.delete(:how_do_you_feel_now)
  end

  def mood(type)
    if type < 1.5
        "happy"
    elsif type >= 1.5 && type < 2.5
        "pleasant"
    elsif type >= 2.5 && type < 3.5
        "sad"
    elsif type >= 3.5
        "angry"
    end
  end

  def cryptor
    cryptor = Cryptor::SymmetricEncryption.new(ENV["SECRET_KEY_CRYPTOR"])
  end

private

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end


end
