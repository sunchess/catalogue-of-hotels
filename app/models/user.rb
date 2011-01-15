# == Schema Information
# Schema version: 20110114173256
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  role_mask            :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,  :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :hotels
  has_many :reserves


  def role
    User.roles[self.role_mask]
  end

  def role?(role)
    if self.role_mask
      User.roles[self.role_mask] == role.to_sym
    else
      false
    end
  end

  def role=(role)
     self.role_mask = User.roles.map{|r| r == role.to_sym ? User.roles.index(r) : nil }.compact.first
  end


  def admin?
    self.role? :admin
  end
  
  
  before_save :check_first_user
  
  private
  def check_first_user
    if User.count == 0
      self.role = "admin"
    end
  end

  def self.roles
    [:user, :admin, :manager]
  end
end
