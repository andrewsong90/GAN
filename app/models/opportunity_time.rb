class OpportunityTime < ActiveRecord::Base

	belongs_to :opportunity

	# Check whether this object is flexible
	def is_flexible?
		self.types == "flexible"		
	end

	# Create the OpportunityTime object
	def self.createTime(opportunity_id,params)
		
		if(params[:time_type]=="flexible")
			t=OpportunityTime.new
			t.opportunity_id=opportunity_id
			t.types="flexible"
			t.date="flexible"
			t.save
		else
			t_from=OpportunityTime.new
			t_to=OpportunityTime.new
			t_from.opportunity_id=opportunity_id
			t_to.opportunity_id=opportunity_id
			t_from.types, t_to.types="range", "range"
			t_from.date=params[:time][0]
			t_to.date=params[:time][1]
			t_from.save
			t_to.save
		end
	end
end
