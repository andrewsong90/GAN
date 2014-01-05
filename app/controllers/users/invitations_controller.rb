class Users::InvitationsController < Devise::InvitationsController

	before_filter :configure_invitations_parameters

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
			u.permit(:fname, :lname, :password, :password_confirmation, :invitation_token, :type, :avatar, :phone, :title, :company, address_attributes: [:id, :address_1, :address_2, :city, :state, :country, :_destroy])
		end
	end
end
