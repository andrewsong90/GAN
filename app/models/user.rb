class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Profile pictures (Paperclip)
  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "100x100>"}

  # Validation
  validates_presence_of :email, :message =>"E-mail cannot be blank"

  has_many :opportunities
  has_many :applications

  has_many :user_skills
  has_many :skills, :through => :user_skills
  
  # Check if the user created the opportunity
  def is_owner? (opportunity)
  	opportunity.user_id == self.id
  end

  def is_alum?
    self.type == "Alum"
  end

  # Check if the user applied to the opportunity
  def applied? (opportunity)
    applications = opportunity.applications.to_a
    logger.debug("APP #{applications}")
    applications.each do |app|
      if app.user_id == self.id
        return true
        break
      end
    end

    return false
  end

  # Returns the full name of the user
  def full_name
  	"#{self.fname} #{self.lname}"
  end

  def attempt_set_password(params)
    p={}
    p[:password]=params[:password]
    p[:password_confirmation]=params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  # User does not have to type in password at the initial step
  def password_required?
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

end
