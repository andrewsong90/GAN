class OpportunitiesController < ApplicationController

	before_filter :authenticate_user, :except => [:about, :welcome, :contact]

	def welcome		
	end


	def main
	end

	# Static page "About"
	def about	
	end

	# Static page "Contact"
	def contact
	end

	def index
		@opportunities = Opportunity.text_search(params[:query])

		#Render CSV and html view
		respond_to do |format|
			format.html
			format.csv { render text: @opportunities.to_csv }
		end
	end

	# Shows opportunities created and applied by current user
	def my_index
		@created_opportunities = current_user.opportunities.all
		logger.debug("Created #{@created_opportunities}")
		if alum_signed_in?
			applications = current_user.applications.all
			@applied_opportunities=[]
			applications.each do |app|
				@applied_opportunities.append(Opportunity.find(app.opportunity_id))
			end
		end
		logger.debug("Applied #{@applied_opportunities}")
	end

	# Show opportunity
	def show
		@opportunity = Opportunity.find(params[:id])
		@skills=@opportunity.skills
		if current_user.applied?(@opportunity)
			flash[:notice] = "You have already applied to this opportunity!"
		end
	end



	def new
		@opportunity=Opportunity.new
		@skills=Skill.all
	end

	def create
		opportunity=current_user.opportunities.build(opportunity_params)

		if opportunity.save

			permitted_params=skill_params
			permitted_params[:skills].each do |skill|
				opportunity.opportunity_skills.create(:skill_id => skill)
			end
			
			flash[:notice] = "Opportunity Created!"
			redirect_to opportunities_path
		else
			flash[:notice] = "Something went Wrong!"
			redirect_to new_opportunity_path
		end

	end

	def edit
		@opportunity = Opportunity.find(params[:id])	
		@skills=Skill.all

		if current_user.is_owner?(@opportunity)
			respond_to do |format|
				format.html
			end
		else
			flash[:error] = "You are not the owner!"
			redirect_to opportunity_path(@opportunity)
		end
	
	end

	def update
		@opportunity = Opportunity.find(params[:id])
		if @opportunity.update(opportunity_params)
			flash[:notice]="Opportunity successfully updated"
			redirect_to opportunity_path(@opportunity)
		else
			flash[:error]="Sorry, the update was not successful"
			redirect_to edit_opportunity_path
		end
	end

	private

	#Strong parameters for opportunities
	def opportunity_params
		params.require(:opportunity).permit(:title,:location,:description,:job_type,:company,:time)
	end

	#Strong parameters for skills
	def skill_params
		params.permit(:skills => [])
	end
	
end
