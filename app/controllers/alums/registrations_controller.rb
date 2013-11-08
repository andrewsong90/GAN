class Alums::RegistrationsController < Devise::RegistrationsController

	before_filter :configure_permitted_params


	def new
		super
	end

	protected

	def configure_permitted_params
		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :fname, :lname, :a)}
		devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :fname, :lname)}
	end
end
