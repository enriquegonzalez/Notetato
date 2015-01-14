class HomeController < ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]
  def index
    if Entry.today(current_user).exists?
      respond_to do |format|
        format.html { redirect_to reports_path }
      end
    else
      @entry = Entry.new
    end
  end

end
