class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.order("date desc")
    @todays_entry = Entry.today(current_user)
    @yesterdays_entry = Entry.yesterday(current_user)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    unless @entry.date == Date.today
      respond_to do |format|
        format.html { redirect_to entry_path, alert: "Sorry Charlie! You can only edit today's Notetato." }
      end
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)


    respond_to do |format|
      if user_signed_in?
        if @entry.save
          format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
          format.json { render :show, status: :created, location: @entry }
        elsif ActiveRecord::RecordNotUnique
            format.html { redirect_to entry_path(todays_entry), alert: "Silly! You've already entered a Notetato today, see." }
        else
          format.html { render :new }
          format.json { render json: @entry.errors, status: :unprocessable_entity }
        end
      else

        cookies[:guest_entry]           = { :value    => "exists",
                                            :expires  => Time.now + 900 }
        cookies[:how_do_you_feel]       = { :value    => entry_params[:how_do_you_feel],
                                            :expires  => Time.now + 900 }
        cookies[:what_went_well]        = { :value    => entry_params[:what_went_well],
                                            :expires  => Time.now + 900 }
        cookies[:what_didnt_go_well]    = { :value    => entry_params[:what_didnt_go_well ],
                                            :expires  => Time.now + 900 }
        cookies[:how_to_make_it_better] = { :value    => entry_params[:how_to_make_it_better],
                                            :expires  => Time.now + 900 }
        cookies[:focus_on_tomorrow]     = { :value    => entry_params[:focus_on_tomorrow ],
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
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
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
      params.require(:entry).permit(:date, :how_do_you_feel, :what_went_well, :what_didnt_go_well, :how_to_make_it_better, :focus_on_tomorrow, :how_do_you_feel_now, :user_id)
    end
end
