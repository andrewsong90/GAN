class Alums::RegistrationsController < Devise::RegistrationsController

	before_filter :configure_permitted_params


	def new
		super
	end

	def create
		logger.debug(sign_up_params)
	end

	protected

	def configure_permitted_params
		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname, :lname, :classyear)}
		devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :fname, :lname, :classyear)}
	end
end
