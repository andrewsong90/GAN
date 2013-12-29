class UsersController < ApplicationController

	before_filter :authenticate_user, :only => [:account, :download]

	def sign_up
		
	end

	# Personal account. Administrator can look at all accounts as of now (Subject to change)
	def show
		
		if params[:id]!=nil
			@user=User.find(params[:id])
		else
			@user=current_user
		end	

		@skills=@user.skills
		@uploads=@user.useruploads.all.to_a
	end

	# Download user's resumes
	def download

		if params[:type]=="display"
			mode = 'inline'
		else
			mode = 'attachment'
		end

		uploads=current_user.useruploads
		if uploads == nil
			flash[:error]= "No attachement exists!"
			redirect_to my_account_path
		else
			upload=uploads.find(params[:id])
			send_file upload.avatar.path,
				:filename => upload.avatar_file_name,
				:type => upload.avatar_content_type,
				:disposition => mode
		end
	end


end
