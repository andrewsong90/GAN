class OpportunityTime < ActiveRecord::Base

	belongs_to :opportunity

	# Check whether this object is flexible
	def is_flexible?
		self.types == "flexible"		
	end

	# Create the OpportunityTime object
	def self.createTime(opportunity,params)
		
		if(params[:time_type]=="flexible")
			t=opportunity.opportunity_times.build(:types => "flexible")
			t.save
		else
			t_from=opportunity.opportunity_times.build(:types => "range", :date => params[:time][0])
			t_to=opportunity.opportunity_times.build(:types => "range", :date => params[:time][1])
			t_from.save
			t_to.save
		end
	end

	def self.updateTime(opportunity,params)
		opportunity.opportunity_times.destroy_all
		if(params[:time_type]=="flexible")	
			t=opportunity.opportunity_times.build(:types => "flexible")
			t.save
		else
			t_from=opportunity.opportunity_times.build(:types => "range", :date => params[:time][0])
			t_to=opportunity.opportunity_times.build(:types => "range", :date => params[:time][1])
			t_from.save
			t_to.save
		end

	end
end
