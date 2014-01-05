class Users::RegistrationsController < Devise::RegistrationsController

	before_filter :registration_permitted_params, :only => :create
	before_filter :update_permitted_params, :only => :update

	def create

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
	      		render 'new'
	    	end

	end

	def edit
		@user=current_user
		@user.useruploads.build
		
		if !@user.address
			@user.build_address
		end
		
		build_unpicked_skills
		@skills=Skill.all
		super
	end

	def update
		@user = User.find(current_user.id)

	    successfully_updated = if needs_password?(@user, params)
	      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
	    else
	      # remove the virtual current_password attribute update_without_password
	      # doesn't know how to ignore it
	      params[:user].delete(:current_password)
	      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
	    end

	    if successfully_updated
	      set_flash_message :notice, :updated
	      # Sign in the user bypassing validation in case his password changed
	      sign_in @user, :bypass => true
	      redirect_to after_update_path_for(@user)
	    else
	      render "edit"
	    end
	end

	protected

	def build_unpicked_skills
		(Skill.all-@user.skills).each do |skill|
			@user.user_skills.build(:skill => skill)
		end
		@user.user_skills.sort_by! {|us| us.skill.id }
	end

	def after_update_path_for(resource)
		user_path(:id => current_user.id)
	end

	def registration_permitted_params
		if params[:user][:type]=="Alum"
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation,:fname,:lname, :classyear, :type, :parent_email)}
		else
			devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname,:lname, :type)}
		end
	end

	def update_permitted_params
		devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password,:title, :company, :phone, :avatar, :fname,:lname, useruploads_attributes: [:id, :avatar, :_destroy], user_skills_attributes: [:id, :skill_id, :_destroy], address_attributes: [:id, :address_1, :address_2, :city, :state, :country, :_destroy])}
	end

	def skill_params
		params.permit(:skills => [])
	end

	def needs_password?(user, params)
		params[:user][:password].present?
	end
end
