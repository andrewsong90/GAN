class AdminsController < ApplicationController

	before_filter :authenticate_admin

	def main
	end

	def view_all_users
		@users=User.all.to_a
	end

	def view_all_applications
		@applications=Application.all.to_a
	end

	def create_new_user
		
	end
end
