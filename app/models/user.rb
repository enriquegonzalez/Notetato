class User < ActiveRecord::Base

  has_one :profile
  has_one :reminder
  has_many :entries

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable




  # def full_name
  #   profile.first_name.capitalize + " " + profile.last_name.capitalize
  # end

  def self.daily_focus_emails
      User.all.each do |recipient|
        recipient.daily_focus_email
      end
  end

  def daily_focus_email
    recipient = self
    yesterdays_entry = Entry.yesterday(recipient).last

    if !yesterdays_entry.nil? && !yesterdays_entry.focus_on_tomorrow.blank?
      todays_focus = yesterdays_entry.focus_on_tomorrow
      ReportMailer.focus_email(recipient, todays_focus).deliver
    end

  end

end
