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

	# Downloading uplodaded file from the opportunity
	def download
		@opportunity=Opportunity.find(params[:id])
		uploads=@opportunity.uploads
		if uploads == nil
			flash[:error]= "No attachement exists!"
			redirect_to opportunity_path(@opportunity)
		else
			upload=uploads.find(params[:upload_id])
			send_file upload.avatar.path,
				:filename => upload.avatar_file_name,
				:type => upload.avatar_content_type,
				:disposition => 'attachment' # To show the pdf file in the page, change it to "inline"
		end				

	end

	def index
		if friend_signed_in?
			opportunities = Opportunity.text_search(params[:query])
			filtered_opportunities = opportunities.select { |opportunity| opportunity.user.id == current_user.id }
			
			#TODO: Manually set the page limit?
			@opportunities = Kaminari.paginate_array(filtered_opportunities).page(params[:page]).per(10)
		else
			@opportunities = Opportunity.text_search(params[:query]).page params[:page]
		end
		
			#Render CSV and html view
			respond_to do |format|
				format.html
				format.csv { render text: @opportunities.to_csv }
			end
		
	end

	# Shows opportunities created and applied by current user
	def my_index
		@created_opportunities = current_user.opportunities.all
		if alum_signed_in?
			applications = current_user.applications.all
			@applied_opportunities=[]
			applications.each do |app|
				@applied_opportunities.append(Opportunity.find(app.opportunity_id))
			end
		end
	end

	# Show opportunity
	def show
		@opportunity = Opportunity.find(params[:id])
		@uploads= @opportunity.uploads.all.to_a
		@skills=@opportunity.skills
		@time=@opportunity.opportunity_times

		# Google map coordiantes
		gon.latitude=@opportunity.latitude
		gon.longitude=@opportunity.longitude
	end

	def new
		@opportunity=Opportunity.new
		@opportunity.uploads.build
		@skills=Skill.all

		respond_to do |format|
			format.html
			format.js
		end
	end

	def upload
		@form=params[:form]
		respond_to do |format|
			format.js
		end
	end

	def create
	
		logger.debug("OPPORTUITY #{opportunity_params}")
		opportunity=current_user.opportunities.build(opportunity_params[:opportunity])

		if opportunity.save

			# permitted_params=skill_params
			skill_params[:skills].each do |skill|
				opportunity.opportunity_skills.create(:skill_id => skill)
			end

			# Create time objects
			OpportunityTime.createTime(opportunity.id, opportunity_params)
			
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
		if @opportunity.update(opportunity_params[:opportunity])
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
		params.permit(:time_type,:time => [],opportunity: [:title,:location,:description,:job_type,:company,:upload, :latitude, :longitude, uploads_attributes: [:id, :avatar, :_destroy]])
	end

	#Strong parameters for skills
	def skill_params
		params.permit(:skills => [])
	end
	
end
