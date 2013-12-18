class Users::RegistrationsController < Devise::RegistrationsController

	before_filter :registration_permitted_params, :only => :create
	before_filter :update_permitted_params, :only => :update

	def new
		@type=params[:type]
		@skills=Skill.all
		super
	end

	def create
		#If database authentiation fails
		if params[:user][:type] == "Alum" && !Userdb.compare_alum_db(params)
				flash[:error] = "Our database does not have your record. Please try again!"
				session[:previous]=params[:user]
				redirect_to :back
		else
		#database authentication success!

			# Clear the session if previous authentication failed.
			session[:previous]=nil

			build_resource(sign_up_params)
			resource.type=params[:user][:type]

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
	    		flash[:error] = "Wrong information"
	      		redirect_to :back
	    	end
    	end
	end

	def edit
		current_user.useruploads.build
		super
	end

	def update
		super		
	end

	protected

	def registration_permitted_params
		if params[:user][:type]=="Alum"
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation,:fname,:lname, :classyear, :type, :parent_email)}
		else
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname,:lname, :type)}
		end
	end

	def update_permitted_params
		devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password, :phone, :avatar, :fname,:lname, useruploads_attributes: [:id, :avatar, :_destroy])}
	end

	def skill_params
		params.permit(:skills => [])
	end
end
