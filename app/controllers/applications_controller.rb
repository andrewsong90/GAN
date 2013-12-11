class ApplicationsController < ApplicationController

	before_filter :authenticate_user

	# Create a new Application
	def new
		
		@opportunity = Opportunity.find(params[:opportunity_id])
		
		if can_apply?(@opportunity)
			@application = Application.new
		else
			flash[:error]="You cannot apply!"
			redirect_to :back
		end
	end

	def create
		application = current_user.applications.build(application_params)
		if application.save
			# UserMailer.submission_email(current_user,application).deliver
			flash[:notice] = "Connection requested! Please check your inbox!"
			redirect_to opportunities_path
		else
			flash[:notice] = "Something went Wrong!"
			redirect_to :back
		end
	end

	private

	def application_params
		params.require(:application).permit(:message,:opportunity_id,:upload)
	end
end
