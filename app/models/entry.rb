class Entry < ActiveRecord::Base
  belongs_to :user

  scope :last_five_days, -> (user) { where("date >= ? AND user_id = ?", 5.days.ago, user.id).limit(5) }
  scope :yesterday, -> (user) { where("date >= ? AND user_id = ?", Date.yesterday, user.id) }
  scope :today, -> (user) { where("date >= ? AND user_id = ?", Date.today, user.id) }

  validates_uniqueness_of :date, :scope => :user_id
  validates_presence_of :how_do_you_feel, :how_do_you_feel_now
  before_create :set_todays_date


  def set_todays_date
    self.date = Date.today
  end

  def save(*args)
    super
  rescue ActiveRecord::RecordNotUnique => error
    false
  end

end
