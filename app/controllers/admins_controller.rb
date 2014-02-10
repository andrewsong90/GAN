class AdminsController < ApplicationController

	before_filter :authenticate_admin

	def main
	end

	def view_all_users
		@users=User.all.to_a
	end

	def view_alum_list
		@alum=Userdb.all.to_a	
	end

	def view_all_applications
		@applications=Application.all.to_a
	end

	def export_applications
		respond_to do |format|
			format.csv { render text: Application.all.to_csv }
		end
	end

	def invitations
		users=User.all.to_a
		@invited_users = users.select {|user| user.invitation_sent_at != nil }

		respond_to do |format|
			format.html
			format.csv { render text: Opportunity.invitation_to_csv }
		end
	end

	def create_new_user
		
	end
end
