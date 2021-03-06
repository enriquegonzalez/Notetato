class Entry < ActiveRecord::Base
  belongs_to :user

  scope :this_week, -> (user) { where("date >= ? AND user_id = ?", Date.current.in_time_zone(user.time_zone).beginning_of_week.to_date, user.id) }
  scope :yesterday, -> (user) { where("date = ? AND user_id = ?", Date.yesterday.in_time_zone(user.time_zone), user.id) }
  scope :today, -> (user) { where("date = ? AND user_id = ?", Date.current.in_time_zone(user.time_zone), user.id) }

  validates_uniqueness_of :date, :scope => :user_id
  validates_presence_of :how_do_you_feel, :how_do_you_feel_now

  before_update :encrypt


  def encrypt
    cryptor = Cryptor::SymmetricEncryption.new(ENV["SECRET_KEY_CRYPTOR"])
    self.what_went_well = cryptor.encrypt(self.what_went_well)
    self.focus_on_tomorrow = cryptor.encrypt(self.focus_on_tomorrow)
  end

  def save(*args)
    super
  rescue ActiveRecord::RecordNotUnique => error
    errors[:base] << "already exists"
    false
  end

end
