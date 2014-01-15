class Skill < ActiveRecord::Base

	has_many :opportunity_skills, :dependent => :destroy
	has_many :opportunities, :through => :opportunity_skills

	has_many :user_skills, :dependent => :destroy
	has_many :users, :through => :user_skills
end
