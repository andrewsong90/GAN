class OpportunitiesController < ApplicationController

	def welcome
		
	end

	def main
		logger.debug("ALUM_SESSION: #{alum_session.inspect}")
		logger.debug("current_user: #{current_user.inspect}")
		logger.debug("CURRENT_USER_CLASS: #{current_user.class.name}")
		#logger.debug("SESSION: #{session.inspect}")
		logger.debug("SESSION_ID: #{session[:session_id].inspect}")	
		#logger.debug("cookies: #{cookies.inspect}")
		#logger.debug("friend_SESSION: #{friend_session.inspect}")
	end
end
