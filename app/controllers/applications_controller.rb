class ApplicationsController < ApplicationController

	before_filter :authenticate_user

	# Create a new Application
	def new
		
		@opportunity = Opportunity.find(params[:opportunity_id])
		
		if can_apply?(@opportunity)
			@application = Application.new
			@uploads = current_user.useruploads.all.to_a
		else
			flash[:error]="You cannot apply!"
			redirect_to :back
		end
	end

	def create
		application = current_user.applications.build(application_params)
		if application.save
			#attachment_params
			UserMailer.submission_email(current_user, application, params[:attachments]).deliver

			flash[:notice] = "Connection requested! Please check your inbox!"
			redirect_to opportunities_path
		else
			flash[:notice] = "Something went Wrong!"
			redirect_to :back
		end
	end

	def show
		@application=Application.find(params[:id])
		@applicant=@application.user
		@opportunity=@application.opportunity
	end

	private

	def application_params
		params.require(:application).permit(:message,:opportunity_id,:upload)
	end

	def attachment_params
		params.permit(:attachments => [])
	end
end
