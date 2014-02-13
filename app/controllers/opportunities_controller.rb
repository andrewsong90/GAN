class OpportunitiesController < ApplicationController

	prepend_before_filter :store_return_to
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

	#This is the main page that all of the users see after login.
	def index

		@post=Post.last
		if friend_signed_in?
			friend_home	
		else
			home
		end
	end

	# This is the opportunities page for Alum and Admins
	def home
		@itemsPerPage=5	
		@opportunities=Opportunity.text_search(params).order("created_at DESC")
		@opportunities = Kaminari.paginate_array(@opportunities).page(params[:page]).per(@itemsPerPage)
		
		logger.debug("OPPORTUNITIES #{@opportunities.size()}")
	
		respond_to do |format|
			format.js
			format.html { render 'index.html.erb'}				
			format.csv { render text: Opportunity.all.to_csv }
		end
	end

	# This is the opportunities page for Friends
	def friend_home
		render "opportunities/friends_index.html.erb"
	end


	# Shows opportunities created and applied by current user
	def my_index
		@created_opportunities = current_user.opportunities.page params[:page]
		#@created_opportunities = Kaminari.paginate_array(created_opportunities).page(params[:page]).per(5)
		if alum_signed_in?
			applications = current_user.applications.all
			@connected_opportunities=[]	
			applications.each do |app|
				@connected_opportunities.append(Opportunity.find(app.opportunity_id))
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
	end

	def new
		@opportunity=Opportunity.new
		@opportunity.uploads.build
		@opportunity.sponsors.build
		build_unpicked_skills

		respond_to do |format|
			format.html
		end
	end

	def create
		@opportunity=current_user.opportunities.new(opportunity_params[:opportunity])
		if @opportunity.save
			# Create time objects
			OpportunityTime.createTime(@opportunity, opportunity_params)
			OpportunityMailer.delay.opportunity_created_email(@opportunity)

			users = User.list_of_interested(@opportunity.skills)

			users.each do |user|
				OpportunityMailer.delay.opportunity_push_email(@opportunity,user)
			end

			flash[:notice] = "Opportunity Created!"
			redirect_to opportunity_path(@opportunity)
		else
			render 'new'
		end
	end	

	def edit
		@opportunity = Opportunity.find(params[:id])	
		build_unpicked_skills

		if current_user.is_owner?(@opportunity) or current_user.is_admin?
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
			OpportunityTime.updateTime(@opportunity, opportunity_params)
			flash[:notice]="Opportunity successfully updated"
			redirect_to opportunity_path(@opportunity)
		else
			render "edit"
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
		temp=current_user.favorite_opportunities.where(:opportunity_id => params[:id]).first_or_create!

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

	private

	def store_return_to
		session[:return_to] = request.url
	end

	def build_unpicked_skills
		(Skill.all-@opportunity.skills).each do |skill|
			@opportunity.opportunity_skills.build(:skill => skill)
		end
		@opportunity.opportunity_skills.sort_by! {|os| os.skill.id }
	end

	#Strong parameters for opportunities
	def opportunity_params
		params.permit(:time_type, :time => [], opportunity: [:edu_level, :active, :title,:location,:description,:job_type,:company,:upload, :latitude, :longitude, sponsors_attributes: [:id,:name, :position, :company,:email, :_destroy], uploads_attributes: [:id, :avatar, :_destroy], opportunity_skills_attributes: [:id, :skill_id, :_destroy]])
	end

	#Strong parameters for skills
	def skill_params
		params.permit(:skills => [])
	end
	





end
