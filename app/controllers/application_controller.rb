class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.type=="Admin"
      admins_posts_path
    elsif resource.type=="Friend" and resource.sign_in_count == 1
      welcome_path
    else
      redirect_back_or_default()
    end
  end

  protected

  def redirect_back_or_default()
    session[:return_to] || opportunities_path
  end

  #Helper method for defining the main link
  def home_path
    if user_signed_in?
      if admin_signed_in?
        admins_posts_path
      else #If Alum or friend
        opportunities_path
      end
    else #If not logged in
      root_path
    end
  end

  #User authentication
  def authenticate_user
		if !user_signed_in?
			flash[:error] = "Please log in to use the service!"
			redirect_to root_path
		end
	end

  def authenticate_admin
    if !admin_signed_in?
      flash[:error] = "You are not the administrator!"
      redirect_to opportunities_path
    end
  end

  #Check whether alumni is signed in
  def alum_signed_in?
    user_signed_in? && (current_user.type=="Alum")  
  end

  #Check whether admin is signed in
  def admin_signed_in?
    user_signed_in? && (current_user.type=="Admin")
  end

  #Check whether friend is signed in
  def friend_signed_in?
    user_signed_in? && (current_user.type=="Friend")    
  end

  #Check whether the current user can apply to the opportunity or not
  def can_apply?(opportunity)

    if alum_signed_in? && !current_user.is_owner?(opportunity) && !current_user.applied?(opportunity)
      true
    else
      false 
    end
  end

  helper_method :alum_signed_in?, :can_apply?, :home_path, :friend_signed_in?
end
