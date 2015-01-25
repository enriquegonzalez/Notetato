class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, :except => [:create]

  # GET /entries
  # GET /entries.json
  def index
    if user_signed_in?
      @todays_entry = Entry.today(current_user).last
      @yesterdays_entry = Entry.yesterday(current_user).last
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @todays_entry = Entry.today(current_user).last
    @yesterdays_entry = Entry.yesterday(current_user).last
  end

  # GET /entries/new
  def new
    if Entry.today(current_user).exists?
      respond_to do |format|
        format.html { redirect_to reports_path }
      end
    else
      @entry = Entry.new
    end
  end

  # GET /entries/1/edit
  def edit
    unless @entry.date == Date.current
      respond_to do |format|
        format.html { redirect_to entry_path, alert: "I like you a lot, but you can only edit today's Notetato." }
      end
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if user_signed_in?
        @entry.what_went_well = cryptor.encrypt(@entry.what_went_well)
        @entry.focus_on_tomorrow = cryptor.encrypt(@entry.focus_on_tomorrow)
        @entry.date = Date.current.in_time_zone(current_user.time_zone)
        @todays_entry = Entry.today(current_user).last
          if @entry.save
            format.html { redirect_to @entry, notice: 'Notetato was successfully created.' }
            format.json { render :show, status: :created, location: @entry }
          elsif @entry.errors[:base].include?("already exists")
               format.html { redirect_to entry_path(@todays_entry), alert: "Silly! You've already entered a Notetato today, see." }
          else
            format.html { render :new }
            format.json { render json: @entry.errors, status: :unprocessable_entity }
          end
      else

        cookies[:guest_entry]           = { :value    => "exists",
                                            :expires  => Time.now + 900 }
        cookies[:how_do_you_feel]       = { :value    => entry_params[:how_do_you_feel],
                                            :expires  => Time.now + 900 }
        cookies[:what_went_well]        = { :value    => cryptor.encrypt(entry_params[:what_went_well]),
                                            :expires  => Time.now + 900 }
        cookies[:focus_on_tomorrow]     = { :value    => cryptor.encrypt(entry_params[:focus_on_tomorrow ]),
                                            :expires  => Time.now + 900 }
        cookies[:how_do_you_feel_now]   = { :value    => entry_params[:how_do_you_feel_now],
                                            :expires  => Time.now + 900 }

        format.html { redirect_to new_user_session_path}

      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Your Notetato was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    entry_date = @entry.date.strftime("%m/%d/%Y")
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Your #{entry_date} Notetato is long gone." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:date, :how_do_you_feel, :what_went_well, :focus_on_tomorrow, :how_do_you_feel_now, :user_id)
    end
end
