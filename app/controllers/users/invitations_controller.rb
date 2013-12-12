class Users::InvitationsController < Devise::InvitationsController

	before_filter :configure_invitations_parameters

	#Only Friends can sign up through invitation
	def edit
		resource.type = "Friend"
		@inviter=User.find(resource.invited_by_id)
		super
	end

	protected

	def configure_invitations_parameters
		logger.debug("INVITED")
		devise_parameter_sanitizer.for(:accept_invitation) do |u|
			u.permit(:fname, :lname, :password, :password_confirmation, :type, :avatar, :phone)
		end
	end
end
