class Entry < ActiveRecord::Base
  belongs_to :user

  scope :last_five_days, -> (user) { where("date >= ? AND user_id = ?", 5.days.ago, user.id).limit(5) }

  validates_uniqueness_of :date
  validates_presence_of :how_do_you_feel, :how_do_you_feel_now
  before_create :set_todays_date


  def set_todays_date
    self.date = Date.today
  end

  def save(*args)
    super
  rescue ActiveRecord::RecordNotUnique => error
    # errors[:base] << error.message
    errors[:base] <<  "You've already created a Notetato today"
    false
  end

end
