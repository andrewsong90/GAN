class Admins::UsersController < ApplicationController
	
	before_filter :authenticate_admin
	before_filter :update_permitted_params, :only => :update

	def index
		@users = User.user_search(params[:query]).order('updated_at DESC').to_a

		respond_to do |format|
			format.html
			format.csv { render text: User.all.to_csv }
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admins_posts_path, :notice => "Administrator successfully created"
		else
			redirect_to admins_new_user_path
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

	def destroy
		@user=User.find(params[:id])
		if @user.destroy
			flash[:notice] = "User successfully deleted"
			redirect_to admins_users_path
		else
			flash[:error] = "User could not be deleted"
			redirect_to admins_user_path(@user)
		end
	end

	private

	def needs_password?(user, params)
		params[:user][:password].present?
	end

	def user_params
		params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation, :type, :confirmed_at, :invitation_limit)
	end

	def update_permitted_params
		params.require(:user).permit(:password, :password_confirmation, :current_password, :phone, :avatar, :fname, :lname, :locked, :invitation_limit)
	end
end
