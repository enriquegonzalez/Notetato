class Moment < ActiveRecord::Base
  belongs_to :user

  scope :mine, -> (user) { where("user.id = ?", user.id) }
  scope :this_week, -> (user) { where("date >= ? AND user_id = ?", Date.current.in_time_zone(user.time_zone).beginning_of_week.to_date, user.id) }
  # scope :yesterday, -> (user) { where("date = ? AND user_id = ?", Date.yesterday.in_time_zone(user.time_zone), user.id) }
  # scope :today, -> (user) { where("date = ? AND user_id = ?", Date.current.in_time_zone(user.time_zone), user.id) }

  validates_presence_of :how_do_you_feel, :why

  before_update :encrypt


  def encrypt
    cryptor = Cryptor::SymmetricEncryption.new(ENV["SECRET_KEY_CRYPTOR"])
    self.why = cryptor.encrypt(self.why)
    self.what_went_well = cryptor.encrypt(self.what_went_well)
  end

end
