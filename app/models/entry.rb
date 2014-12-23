class Entry < ActiveRecord::Base
  belongs_to :user

  scope :last_five_days, -> (user) { where("date >= ? AND user_id = ?", 5.days.ago, user.id).limit(5) }

  before_create :set_todays_date

  def set_todays_date
    self.date = Date.today
  end

end
