class ApplicationsController < ApplicationController

	# Create a new Application
	def new
		@application = Application.new
		@opportunity = Opportunity.find(params[:opportunity_id])
	end

	def create
		application = current_user.applications.build(application_params)
		if application.save
			UserMailer.submission_email(current_user,application).deliver
			flash[:notice] = "Application Created!"
			redirect_to main_path
		else
			flash[:notice] = "Something went Wrong!"
			#TODO: redfine the path!
			#redirect_to new_opportunity_path
		end
	end

	private

	def application_params
		params.require(:application).permit(:message,:opportunity_id)
	end
end
