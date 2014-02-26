class ContactsController < ApplicationController

	def new
		@contact=Contact.new
		@categories=Contact.categories
	end

	def create

		@contact=Contact.new(permitted_params)

		if user_signed_in?
			@contact.name=current_user.full_name
			@contact.from_email=current_user.email
		end
		
		@category=params[:category]
		if verify_recaptcha(:model => @contact, :message => "Captcha error!") && @contact.save
			UserMailer.delay.contact_email_to_user(@contact, @category)
			UserMailer.delay.contact_email_to_admin(@contact, @category)
			flash[:notice] = "The admininstrator will contact you shortly."
			redirect_to after_contact_path
		else
			render 'new'	
		end
	end

	private

	def permitted_params
		params.require(:contact).permit(:title,:from_email,:content,:name)
	end

	def after_contact_path
		if user_signed_in?
			opportunities_path
		else
			root_path
		end
	end

end
