class OpportunitiesController < ApplicationController

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

	def index
		@opportunities=Opportunity.all
	end

	def show
		@opportunity = Opportunity.find(params[:id])
		logger.debug("Owner #{@opportunity.user}")
	end



	def new
		@opportunity=Opportunity.new
	end

	def create
		opportunity=current_user.opportunities.build(opportunity_params)
		if opportunity.save
			flash[:notice] = "Opportunity Created!"
			redirect_to main_path
		else
			flash[:notice] = "Something went Wrong!"
			redirect_to new_opportunity_path
		end
	end

	def edit
		@opportunity = Opportunity.find(params[:id])	
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

end
