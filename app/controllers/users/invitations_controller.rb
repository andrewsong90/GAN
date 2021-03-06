class Users::InvitationsController < Devise::InvitationsController

	before_filter :configure_invitations_parameters

	def after_invite_path_for(resource)
		new_user_invitation_path
	end

	def new
		@user=User.new
	end

	# Change this tomorrow morning
	def create
		if !(@user=User.new(:email => params[:email], :fname => params[:fname], :lname => params[:lname])).valid?
			render 'new'
		else
			@user = User.invite!({:email => params[:email], :fname => params[:fname], :lname => params[:lname], :sponsor_email => params[:email], :sponsor_fname => params[:fname], :sponsor_lname => params[:lname]},current_user) do |user|
				user.skip_invitation = true
			end

			@user.update_attribute :invitation_sent_at, Time.now.utc
			@token = @user.raw_invitation_token
			@title = params[:title]
			@content = params[:content]
			UserMailer.delay.invite_message(@user, @token, @title, @content)
			
			flash[:notice] = "The email was sent to the invitee"
			redirect_to new_user_invitation_path
		end
	end

	# Page for sending out custom template invites
	def batch_new
	end

	def batch_invite
		list_of_users=Friend.import(params[:file])
		list_of_users.each do |user_hash|
			@user = User.invite!({:email => user_hash["email"],:fname => user_hash["first_name"],:lname => user_hash["last_name"], :sponsor_email => user_hash["email"], :sponsor_fname => user_hash["fname"], :sponsor_lname => user_hash["lname"]},current_user) do |user|
				user.skip_invitation = true
			end

			@user.update_attribute :invitation_sent_at, Time.now.utc
			@token = @user.raw_invitation_token
			@title = params[:title]
			@content = params[:content]
			UserMailer.delay.invite_message(@user, @token, @title, @content)
		end

		redirect_to admins_posts_path
	end

	#Only Friends can sign up through invitation
	def edit
		resource.type = "Friend"
		resource.build_address
		@inviter=User.find(resource.invited_by_id)
		super
	end

	def update
		self.resource = resource_class.accept_invitation!(update_resource_params)

	    if resource.errors.empty?
	      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
	      set_flash_message :notice, flash_message
	      sign_in(resource_name, resource)
	      respond_with resource, :location => after_accept_path_for(resource)
	    else
	   	  resource.build_address
	      respond_with_navigational(resource){ render :edit }
	    end
	end

	protected

	def configure_invitations_parameters
		devise_parameter_sanitizer.for(:accept_invitation) do |u|
			u.permit(:email, :fname, :lname, :password, :password_confirmation, :invitation_token, :type, :avatar, :phone, :title, :company, address_attributes: [:id, :address_1, :address_2, :city, :state, :country, :_destroy])
		end
	end
end
