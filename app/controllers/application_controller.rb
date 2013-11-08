class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?

  def after_sign_in_path_for(resource)
  	main_path	
  end

  private

  def current_user
  	if alum_signed_in?
  		@current_user = current_alum	
  	elsif friend_signed_in?
  		@current_user = current_friend
  	else
  		nil
  	end
  		
  end

  def user_signed_in?
  	  alum_signed_in? or friend_signed_in?	
  end
end
