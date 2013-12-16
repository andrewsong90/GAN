class UploadsController < ApplicationController

	def new
		logger.debug("CALLED THE LINK")
		respond_to do |format|
			format.js
		end
	end
end
