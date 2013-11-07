class Friends::RegistrationsController < Devise::RegistrationsController

	before_filter :configure_permitted_params

	protected

	def configure_permitted_params
		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname, :lname)}
	end

end
