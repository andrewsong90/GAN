class Opportunity < ActiveRecord::Base

	has_many :opportunity_skills
	has_many :skills, :through => :opportunity_skills

	belongs_to :user
	has_many :applications

	include PgSearch
	pg_search_scope :search, against: [:title, :description]

	def self.text_search(query)
		logger.debug("QUuery #{query}")
		if query.present?
			search(query)
		else
			scoped
		end
	end
	
end
