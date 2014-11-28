class HomeController < ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entry = Entry.new
  end

end
