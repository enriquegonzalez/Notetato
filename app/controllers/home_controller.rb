class HomeController < ApplicationController
  def index
    if user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_moment_path }
      end
    else
      @moment = Moment.new
    end
  end

end
