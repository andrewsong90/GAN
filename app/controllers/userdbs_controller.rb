class UserdbsController < ApplicationController

	def import
		Userdb.import(params[:file])
		redirect_to main_path
	end
end
