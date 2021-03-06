class HomeController < ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]
  def index
    if user_signed_in? && Entry.today(current_user).exists?
      respond_to do |format|
        format.html { redirect_to reports_path }
      end
    elsif user_signed_in? && !Entry.today(current_user).exists?
      respond_to do |format|
        format.html { redirect_to new_entry_path }
      end
    else
      @entry = Entry.new
    end
  end

end
