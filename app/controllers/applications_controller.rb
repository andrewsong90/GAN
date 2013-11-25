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
			UserMailer.submission_email(current_user,application).deliver
			flash[:notice] = "Application Created!"
			redirect_to main_path
		else
			flash[:notice] = "Something went Wrong!"
			redirect_to :back
		end
	end

	private

	def application_params
		params.require(:application).permit(:message,:opportunity_id)
	end

	# def can_apply?

	# 	opportunity = Opportunity.find(params[:opportunity_id])

	# 	if alum_signed_in? 
	# 		&& !current_user.is_owner?(opportunity)
	# 		&& !current_user.applied?(opportunity)
	# 		true
	# 	else
	# 		false
	# 	end
	# end
end
