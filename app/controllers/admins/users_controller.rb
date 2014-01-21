class Admins::UsersController < ApplicationController
	
	before_filter :update_permitted_params, :only => :update
	def index
		@users = User.user_search(params[:query]).order('fname').to_a

		respond_to do |format|
			format.html
			format.csv { render text: User.all.to_csv }
		end

	end

	def edit
		@user=User.find(params[:id])
	end

	def show
		@user=User.find(params[:id])	
	end

	def update
		@user=User.find(params[:id])

		successfully_updated = if needs_password?(@user,params)
			@user.update_with_password(update_permitted_params)
		else
			params[:user].delete(:current_password)
			@user.update_without_password(update_permitted_params)
		end

		if successfully_updated
			flash[:notice] = "Successfully Updated!"
			redirect_to admins_user_path(@user)
		else
			flash[:error] = "Something went wrong"
			render "edit"
		end

	end



	private

	def needs_password?(user, params)
		params[:user][:password].present?
	end

	def update_permitted_params
		params.require(:user).permit(:password, :password_confirmation, :current_password, :phone, :avatar, :fname, :lname, :locked, :invitation_limit)
	end
end
