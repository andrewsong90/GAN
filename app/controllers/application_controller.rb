class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_customer, :customer_signed_in?

  private

  def current_customer
  end

  def customer_signed_in?
  	  alum_signed_in? or friend_signed_in?	
  end
end
