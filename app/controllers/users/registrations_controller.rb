class Users::RegistrationsController < Devise::RegistrationsController

	before_filter :configure_permitted_params

	def new
		@type=params[:type]
		super
	end

	def create
		build_resource(sign_up_params)
		
		#This is for subclasses
		resource.type=params[:type]
		
		if resource.save
      		yield resource if block_given?
      		if resource.active_for_authentication?
        		set_flash_message :notice, :signed_up if is_flashing_format?
        		sign_up(resource_name, resource)
        		respond_with resource, :location => after_sign_up_path_for(resource)
      		else
        		set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        		expire_data_after_sign_in!
        		respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      		end
    	else
      		clean_up_passwords resource
      		respond_with resource
    	end
	#	super
	end

	protected

	def configure_permitted_params
		if params[:type]="Alum"
			logger.debug("ALUM SANITIZER")
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname,:type)}
		else
			logger.debug("Friend SANITIZER")
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :type)}
		end
	end

end
