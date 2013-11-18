class OpportunitiesController < ApplicationController

	before_filter :authenticate_user, :except => [:about, :welcome]

	def welcome
		
	end

	def main
		# logger.debug("ALUM_SESSION: #{alum_session.inspect}")
		# logger.debug("current_user: #{current_user.inspect}")
		# logger.debug("CURRENT_USER_CLASS: #{current_user.class.name}")
		# #logger.debug("SESSION: #{session.inspect}")
		# logger.debug("SESSION_ID: #{session[:session_id].inspect}")	
		# #logger.debug("cookies: #{cookies.inspect}")
		# #logger.debug("friend_SESSION: #{friend_session.inspect}")
	end

	def about
		
	end

	def index
		@opportunities=Opportunity.all
	end

	def show
		@opportunity = Opportunity.find(params[:id])
		@skills = []
		@opportunity.opportunity_skills.each do |set|
			@skills.append(Skill.find(set.skill_id))
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

	#TODO : Still need to do edit part

	def edit
		@opportunity = Opportunity.find(params[:id])	
		@skills=Skill.all

		if current_user.is_owner?(@opportunity)
			render :action => "edit"
		else
			redirect_to opportunity_path(@opportunity)
		end
	
	end

	def update
		opportunity = Opportunity.find(params[:id])
		if opportunity.update(opportunity_params)
			redirect_to main_path
		else
			redirect_to edit_opportunity_path
		end
	end

	private

	def opportunity_params
		params.require(:opportunity).permit(:title,:location,:description,:job_type,:company,:time)
	end

	def skill_params
		params.permit(:skills => [])
	end
	
end
