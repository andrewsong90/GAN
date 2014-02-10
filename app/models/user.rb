class User < ActiveRecord::Base

  after_create :update_alum_record

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Profile pictures (Paperclip)
  has_attached_file :avatar, :styles => {:medium => "270x270>", :thumb => "130x130>"}, :default_url => "/images/user/:style/missing.png"

  # Validation
  validates_presence_of :fname, :message =>"can't be blank"
  validates_presence_of :lname, :message =>"can't be blank"
  validates_presence_of :classyear, :message => "can't be blank", if: :is_alum?
  validates_presence_of :parent_email, :message => "can't be blank", if: :is_alum?
  validates :password, confirmation: true

  # validate :check_alum_record, if: :is_alum?
  validate :check_alum_record, if: :is_alum?

  has_many :opportunities
  has_many :applications

  has_many :user_skills, :dependent => :destroy
  has_many :skills, :through => :user_skills
  accepts_nested_attributes_for :user_skills, :allow_destroy => true
  
  # Multiple uploads
  has_many :useruploads
  accepts_nested_attributes_for :useruploads, :reject_if => :all_blank, :allow_destroy => true

  # Favorite Opportunities
  has_many :favorite_opportunities, :dependent => :destroy
  has_many :favorites, :through => :favorite_opportunities, :source => :opportunity
  
  # Address
  has_one :address
  accepts_nested_attributes_for :address, :reject_if => :all_blank, :allow_destroy => true

  attr_reader :raw_invitation_token

  #Configuration for database search
  include PgSearch
  pg_search_scope :search_user, 
          :against => [:type, :fname, :lname],
          :using => {
            :tsearch => {:prefix => true}
          }



  # Validation
  def check_alum_record
    if !Userdb.where("(parent_email_1 = ? OR parent_email_2 = ?) AND classyear = ?",parent_email, parent_email, classyear).first 
      errors.add(:base, "The combination of parent email & Gann graduation class doesn't match our database")
    end  
  end

  def update_alum_record
    alum=Userdb.where("(parent_email_1 = ? OR parent_email_2 = ?) AND classyear = ? AND registered=?",parent_email, parent_email, classyear, false).first  
    alum.update_attributes(:registered => true)
    alum.save
  end

  #Database Search
  def self.user_search(query)
    if query.present?
      search_user(query)
    else
      all
    end
  end


  # Check if the user created the opportunity
  def is_owner? (opportunity)
  	opportunity.user_id == self.id
  end

  def is_alum?
    type == "Alum"
  end

  def is_admin?
    type == "Admin"
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

  # Return list of users that have corresponding skillset
  def self.list_of_interested(skills)
    list_of_interested=Array.new
    
    # logger.debug("SKILLS #{skills}, #{skills.length}")

    if skills.length != 0
      skills.each do |skill|
        skill.users.each do |user|
          if !list_of_interested.include?(user)
            list_of_interested.append(user)
          end
        end
      end
    end

    list_of_interested
  end

  #Export to CSV
  def self.to_csv
    CSV.generate do |csv|
      features = ["id","type","fname","lname","classyear","email","title","company","phone","sign_in_count","last_sign_in_at","invitation_limit", "updated_at", "created_at"]
      features_with_address = features+["address_1","address_2","city","state","country","zipcode"]
      csv << features_with_address
      all.each do |user|
        row = user.attributes.slice(*features).values
        if user.address
          row.append(user.address.address_1)
          row.append(user.address.address_2)
          row.append(user.address.city)
          row.append(user.address.state)
          row.append(user.address.country)
          row.append(user.address.zipcode)
        end
        csv << row
      end
    end
  end

end
