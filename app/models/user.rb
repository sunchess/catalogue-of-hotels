class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,  :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  #roles
  ROLES = [:user, :admin, :manager]

  def role
    ROLES[self.role_mask]
  end

  def role?(role)
    if self.role_mask
      ROLES[self.role_mask] == role.to_sym
    else
      false
    end
  end

  def role=(role)
     self.role_mask = ROLES.map{|r| r == role.to_sym ? ROLES.index(r) : nil }.compact.first  
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
end
