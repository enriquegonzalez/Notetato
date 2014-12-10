class Entry < ActiveRecord::Base
  belongs_to :user

  before_create :set_todays_date

  def set_todays_date
    self.date = Date.today
  end

end
