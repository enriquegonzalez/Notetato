class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!

  respond_to :html

  def index
    @reminders = Reminder.all
    respond_with(@reminders)
  end

  def show
    respond_with(@reminder)
  end

  def new
    @reminder = Reminder.new
    respond_with(@reminder)
  end

  def edit
  end

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.save
    respond_with(@reminder)
  end

  def update
    @reminder.update(reminder_params)
    respond_with(@reminder)
  end

  def destroy
    @reminder.destroy
    respond_with(@reminder)
  end

  private
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    def reminder_params
      params.require(:reminder).permit(:user_id, :by_phone, :by_email, :time)
    end
end
