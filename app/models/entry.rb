class Entry < ActiveRecord::Base
  belongs_to :user

  scope :this_week, -> (user) { where("date >= ? AND user_id = ?", Date.current.beginning_of_week, user.id) }
  scope :yesterday, -> (user) { where("date = ? AND user_id = ?", Date.yesterday.in_time_zone(user.time_zone), user.id) }
  scope :today, -> (user) { where("date = ? AND user_id = ?", Date.current.in_time_zone(user.time_zone), user.id) }

  validates_uniqueness_of :date, :scope => :user_id
  validates_presence_of :how_do_you_feel, :how_do_you_feel_now


  def save(*args)
    super
  rescue ActiveRecord::RecordNotUnique => error
    errors[:base] << "already exists"
    false
  end

end
