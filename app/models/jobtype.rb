class Jobtype < ActiveRecord::Base

	def self.type_search (opportunities, type_id)
		if type_id != "" && type_id != nil
			type=self.find(type_id).name
			filtered_opportunities = opportunities.select {|opportunity| opportunity.job_type == type }
			filtered_opportunities
		else
			all
		end
	end
end
