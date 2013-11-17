class Users::RegistrationsController < Devise::RegistrationsController

	before_filter :configure_permitted_params, :only => ["create","update"]

	def new
		@type=params[:type]
		@skills=Skill.all
		super
	end

	def create

		build_resource(sign_up_params)
		
		#This is for subclasses
		resource.type=params[:user][:type]

		if resource.save
			UserMailer.welcome_email(resource).deliver
      		yield resource if block_given?
      		if resource.active_for_authentication?

      			permitted_params=skill_params
				permitted_params[:skills].each do |skill|
					resource.user_skills.create(:skill_id => skill)
				end

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
	end

	protected

	def configure_permitted_params
	
		if params[:user][:type]=="Alum"
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname,:lname, :classyear, :type, :avatar)}
			devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :fname,:lname, :avatar)}
		else
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname,:lname, :type)}
			devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :fname,:lname)}
		end
	end

	def skill_params
		params.permit(:skills => [])
	end
end
