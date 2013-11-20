class Opportunity < ActiveRecord::Base

	has_many :opportunity_skills
	has_many :skills, :through => :opportunity_skills

	belongs_to :user
	has_many :applications

	include PgSearch
	pg_search_scope :search, against: [:title, :description]

	#Database Search
	def self.text_search(query)
		logger.debug("QUuery #{query}")
		if query.present?
			search(query)
		else
			scoped
		end
	end

	#Export to CSV
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |opportunity|
				csv << opportunity.attributes.values_at(*column_names)
			end
		end
	end
	
end
