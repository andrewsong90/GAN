class ContactsController < ApplicationController

	def new
		@contact=Contact.new
		@categories=Contact.categories
	end

	def create
		@contact=Contact.new(permitted_params)
		@category=params[:category]
		logger.debug("Coooontact #{@category}")
		if verify_recaptcha(:model => @contact, :message => "Captcha error!") && @contact.save
			logger.debug(@category)
			logger.debug(@contact)
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
		params.require(:contact).permit(:title,:from_email,:content)
	end

	def after_contact_path
		if user_signed_in?
			opportunities_path
		else
			root_path
		end
	end

end
