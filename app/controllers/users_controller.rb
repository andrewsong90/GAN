class UsersController < ApplicationController

	before_filter :authenticate_user, :only => [:account, :download]

	# Personal account. Administrator can look at all accounts as of now (Subject to change)
	def show
		if ((user=User.find(params[:id]))==current_user)
			@user=current_user
			@skills=@user.skills
			@uploads=@user.useruploads.all.to_a
		#If administrator, he has the access to every account
		elsif admin_signed_in?
			@user = User.find(params[:id])
			@skills=@user.skills
			@uploads=@user.useruploads.all.to_a
		else
			flash[:error] = "You do not have access to the page"
			redirect_to opportunities_path
		end
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
