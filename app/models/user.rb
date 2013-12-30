class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Profile pictures (Paperclip)
  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "130x130>"}, :default_url => "/images/user/:style/missing.png"

  # Validation
  validates_presence_of :fname, :message =>"can't be blank"
  validates_presence_of :lname, :message =>"can't be blank"
  validates_presence_of :classyear, :message => "can't be blank", if: :is_alum?
  validates_presence_of :parent_email, :message => "can't be blank", if: :is_alum?

  validate :check_alum_record, if: :is_alum?

  has_many :opportunities
  has_many :applications

  has_many :user_skills, :dependent => :destroy
  has_many :skills, :through => :user_skills
  accepts_nested_attributes_for :user_skills, :allow_destroy => true
  
  # Multiple uploads
  has_many :useruploads
  accepts_nested_attributes_for :useruploads, :reject_if => :all_blank, :allow_destroy => true

  has_many :favorite_opportunities, :dependent => :destroy
  has_many :favorites, :through => :favorite_opportunities, :source => :opportunity
  

  #Validation
  def check_alum_record
    if !Userdb.where(:parent_email =>parent_email, :classyear => classyear).first 
      errors.add(:base, "The combination of parent email & Gann graduation class doesn't match our database")
    end  
  end

  # Check if the user created the opportunity
  def is_owner? (opportunity)
  	opportunity.user_id == self.id
  end

  def is_alum?
    type == "Alum"
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

  # If the user is blocked from the site
  def is_locked?
    locked
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

  # Override Devise/authenticatable.rb
  def update_without_password(params,*options)
    params.delete(:password)
    params.delete(:password_confirmation)

    result = update_attributes(params)
    result
  end

end
