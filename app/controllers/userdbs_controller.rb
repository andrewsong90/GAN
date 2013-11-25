class UserdbsController < ApplicationController

	#Importing CSV file
	def import
		Userdb.import(params[:file])
		flash[:notice] = "CSV file successfully uploaded!"
		redirect_to admin_main_path
	end
end
