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

	# Downloading or viewing uplodaded file from the opportunity
	def download

		if params[:type]=="display"
			mode = 'inline'
		else
			mode = 'attachment'
		end

		@opportunity=Opportunity.find(params[:id])
		uploads=@opportunity.uploads
		if uploads == nil
			flash[:error]= "No attachment exists!"
			redirect_to opportunity_path(@opportunity)
		else
			upload=uploads.find(params[:upload_id])
			send_file upload.avatar.path,
				:filename => upload.avatar_file_name,
				:type => upload.avatar_content_type,
				:disposition => mode # To show the pdf file in the page, change it to "inline"
		end				

	end

	# TODO: No pagination yet
	def index
		@post=Post.last
		if friend_signed_in?
			opportunities = Opportunity.text_search(params).order("created_at DESC").to_a
			filtered_opportunities = opportunities.select { |opportunity| opportunity.user.id == current_user.id }
			@opportunities = Opportunity.type_search(filtered_opportunities,params[:job_type])
			# @opportunities = Kaminari.paginate_array(filtered_opportunities).page(params[:page]).per(5)
			# @opportunities=opportunities
		else
			# opportunities = Opportunity.text_search(params).page params[:page]
			opportunities=Opportunity.text_search(params).order("created_at DESC").to_a
			filtered_opportunities = Opportunity.type_search(opportunities,params[:job_type])
			# @opportunities = Kaminari.paginate_array(filtered_opportunities).page(params[:page]).per(10)
			@opportunities = filtered_opportunities
			# @opportunities = Opportunity.search_opportunity(params[:query]).page params[:page]
		end
		
			#Render CSV and html view
			respond_to do |format|
				format.html
				format.csv { render text: @opportunities.to_csv }
			end
	end

	# Shows opportunities created and applied by current user
	def my_index
		@created_opportunities = current_user.opportunities.page params[:page]
		#@created_opportunities = Kaminari.paginate_array(created_opportunities).page(params[:page]).per(5)
		if alum_signed_in?
			applications = current_user.applications.all
			@applied_opportunities=[]	
			applications.each do |app|
				@applied_opportunities.append(Opportunity.find(app.opportunity_id))
			end

			@favorites = current_user.favorites
		end
	end

	# Show opportunity
	def show
		@opportunity = Opportunity.find(params[:id])
		@uploads = @opportunity.uploads.all.to_a
		@sponsors = @opportunity.sponsors.all.to_a
		@skills=@opportunity.skills
		@time=@opportunity.opportunity_times

		# Google map coordiantes
		gon.latitude=@opportunity.latitude
		gon.longitude=@opportunity.longitude
	end

	def new
		@opportunity=Opportunity.new
		@opportunity.uploads.build
		@opportunity.sponsors.build
		build_unpicked_skills

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

	# Save the opportunities to the favorite list (AJAX)
	def add_to_favorites
		opportunity=Opportunity.find(params[:id])
		temp=opportunity.favorite_opportunities.first_or_create!(:user_id => current_user.id)

		respond_to do |format|
			format.json {render :json => {:message => "success"}}
		end
	end

	# Delete opportunities from favorite list (AJAX)
	def remove_from_favorites
		current_user.favorites.delete(params[:id])
	
		respond_to do |format|
			format.json {render :json => {:message => "success"}}
		end
	end

	def create
		opportunity=current_user.opportunities.build(opportunity_params[:opportunity])

		if opportunity.save
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
		build_unpicked_skills

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

	def build_unpicked_skills
		(Skill.all-@opportunity.skills).each do |skill|
			@opportunity.opportunity_skills.build(:skill => skill)
		end
		@opportunity.opportunity_skills.sort_by! {|os| os.skill.id }
	end


	#Strong parameters for opportunities
	def opportunity_params
		params.permit(:time_type, :time => [], opportunity: [:active, :title,:location,:description,:job_type,:company,:upload, :latitude, :longitude, sponsors_attributes: [:id,:name, :position, :company,:email, :_destroy], uploads_attributes: [:id, :avatar, :_destroy], opportunity_skills_attributes: [:id, :skill_id, :_destroy]])
	end

	#Strong parameters for skills
	def skill_params
		params.permit(:skills => [])
	end
	
end
