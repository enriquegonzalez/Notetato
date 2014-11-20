class User < ActiveRecord::Base

  has_one :profile
  has_one :diary

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def full_name
    profile.first_name.capitalize + " " + profile.last_name.capitalize
  end

end
