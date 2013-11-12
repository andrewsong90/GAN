class Opportunity < ActiveRecord::Base

	has_and_belongs_to_many :skills 
	belongs_to :user
	has_many :applications
end
