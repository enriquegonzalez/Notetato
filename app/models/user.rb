class User < ActiveRecord::Base

  has_one :profile
  has_one :reminder
  has_many :moments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email

  validates :time_zone,
    inclusion: {
      in: ActiveSupport::TimeZone.zones_map(&:name).keys
    }


  def self.daily_moments_emails
      User.all.each do |recipient|
        recipient.daily_moments_email
      end
  end

  def daily_moments_email
    recipient = self
    cryptor = Cryptor::SymmetricEncryption.new(ENV["SECRET_KEY_CRYPTOR"])
    if Time.current.in_time_zone(recipient.time_zone).hour == 7
      yesterdays_moments = Moment.yesterday(recipient)

      if !yesterdays_moments.nil?
        yesterdays_moments = cryptor.decrypt(yesterdays_moments)
        ReportMailer.moments_email(recipient, yesterdays_moments).deliver
      end
    end
  end


  ########################################
  ### Entries and Focus are phased out ###
  ########################################
  # has_many :entries
  #
  # def self.daily_focus_emails
  #     User.all.each do |recipient|
  #       recipient.daily_focus_email
  #     end
  # end
  #
  # def daily_focus_email
  #   recipient = self
  #   cryptor = Cryptor::SymmetricEncryption.new(ENV["SECRET_KEY_CRYPTOR"])
  #   if Time.current.in_time_zone(recipient.time_zone).hour == 7
  #     yesterdays_entry = Entry.yesterday(recipient).last

  #     if !yesterdays_entry.nil? && !yesterdays_entry.focus_on_tomorrow.blank?
  #       todays_focus = cryptor.decrypt(yesterdays_entry.focus_on_tomorrow)
  #       ReportMailer.focus_email(recipient, todays_focus).deliver
  #     end
  #   end
  # end

end
