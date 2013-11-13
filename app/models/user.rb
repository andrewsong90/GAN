class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :opportunities
  has_many :applications

  has_many :user_skills
  has_many :skills, :through => :user_skills
  
  def is_owner? (opportunity)
  	opportunity.user_id == self.id
  end

  def full_name
  	"#{self.fname} #{self.lname}"
  end

end
