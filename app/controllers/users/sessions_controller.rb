class Users::SessionsController < Devise::SessionsController

	
	# Refuse login if the user account is locked
	def create
		self.resource = warden.authenticate!(auth_options)
		if self.resource.is_locked?
			flash[:error] = "You are locked out. Please contact the administrator for more details."
			sign_out(resource_name)
			redirect_to root_path
		else
	    	set_flash_message(:notice, :signed_in) if is_flashing_format?
	    	sign_in(resource_name, resource)
	    	yield resource if block_given?
	    	respond_with resource, :location => after_sign_in_path_for(resource)
	    end	
	end	
end
