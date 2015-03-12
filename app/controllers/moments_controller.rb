class MomentsController < ApplicationController
  before_action :set_moment, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, :except => [:create]

  respond_to :html

  def index
    @moments_today = Moment.mine_today(current_user)
    @moments_yesterday = Moment.mine_yesterday(current_user)
    @moments = Moment.mine(current_user)
    # @moment_dates = Moment.my_moment_dates(current_user)



    respond_with(@moments)
  end

  def show
    respond_with(@moment)
  end

  def new
    @moment = Moment.new
    respond_with(@moment)
  end

  def edit
    @moment.why = cryptor.decrypt(@moment.why)
    @moment.what_went_well = cryptor.decrypt(@moment.what_went_well)
  end

  def create
    @moment = Moment.new(moment_params)
    respond_to do |format|
      if user_signed_in?
        @moment.why = cryptor.encrypt(@moment.why)
        @moment.what_went_well = cryptor.encrypt(@moment.what_went_well)
        @moment.date = Date.current.in_time_zone(current_user.time_zone)
          if @moment.save
            format.html { redirect_to @moment, notice: 'Moment was successfully created.' }
            format.json { render :show, status: :created, location: @moment }
          else
            format.html { render :new }
            format.json { render json: @moment.errors, status: :unprocessable_entity }
          end
      else
        cookies[:guest_moment]           = { :value    => "exists",
                                            :expires  => Time.now + 900 }
        cookies[:how_do_you_feel]       = { :value    => moment_params[:how_do_you_feel],
                                            :expires  => Time.now + 900 }
        cookies[:why]                   = { :value    => cryptor.encrypt(moment_params[:why]),
                                            :expires  => Time.now + 900 }
        cookies[:what_went_well]        = { :value    => cryptor.encrypt(moment_params[:what_went_well]),
                                            :expires  => Time.now + 900 }

        format.html { redirect_to new_user_session_path}

      end
    end
  end

  def update
    @moment.update(moment_params)
    respond_with(@moment)
  end

  def destroy
    @moment.destroy
    respond_with(@moment)
  end

  private
    def set_moment
      @moment = Moment.find(params[:id])
    end

    def moment_params
      params.require(:moment).permit(:date, :how_do_you_feel, :why, :what_went_well, :user_id)
    end

end
