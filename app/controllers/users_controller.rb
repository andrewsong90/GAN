class UsersController < ApplicationController

	before_filter :authenticate_user, :only => [:account, :download]

	def sign_up
		
	end

	#new User session
	def sign_in
		
	end

	def account	
		@uploads=current_user.useruploads.all.to_a
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
				:disposition => mode # To show the pdf file in the page, change it to "inline"
		end
	end


end
