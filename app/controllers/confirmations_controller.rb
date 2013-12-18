#Controller for Confriming users
class ConfirmationsController < Devise::ConfirmationsController
	skip_before_filter :authenticate_user!, except: [:confirm_user]

	def update
		with_unconfirmed_confirmable do
			if @confirmable.has_no_password?
				
				#Update password
				@confirmable.attempt_set_password(params[:user])
			
				#Update rest of the Information
				@confirmable.update_attributes(:avatar => params[:user][:avatar],:phone => params[:user][:phone])
				if @confirmable.valid?
					do_confirm
				else
					do_show
					@confirmable.errors.clear
				end
			else
				self.class.add_error_on(self, :email, :password_allready_set)
			end
		end

		if !@confirmable.errors.empty?
			render 'devise/confirmations/new'
		end

	end


	# GET /resource/confirmation?confirmation_token=abcdef
	def show
		with_unconfirmed_confirmable do 
			if @confirmable.has_no_password?
				do_show
			else
				do_confirm
			end
		end

		if !@confirmable.errors.empty?
			self.resource=@confirmable
			render 'devise/confirmations/new'
		end
	end


	protected

	def configure_permitted_params
		params.require(:user).permit(:avatar,:phone)
	end

	def with_unconfirmed_confirmable
		original_token = params[:confirmation_token]
		confirmation_token = Devise.token_generator.digest(User, :confirmation_token, original_token)	
		@confirmable = User.find_or_initialize_with_error_by(:confirmation_token, confirmation_token)
		if !@confirmable.new_record?
			@confirmable.only_if_unconfirmed {yield}
		end	
	end

	def do_show
		@confirmation_token = params[:confirmation_token]
		@requires_password = true
		self.resource = @confirmable
		logger.debug("DO SHOW")
		logger.debug("PARAMS #{params[:confirmation_token]}")
		render 'devise/confirmations/show'
	end

	def do_confirm
		@confirmable.confirm!
		set_flash_message :notice, :confirmed
		sign_in_and_redirect(resource_name,@confirmable)
	end
end
