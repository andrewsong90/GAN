class ContactsController < ApplicationController

	def new
		@contact=Contact.new
	end

	def create
		@contact=Contact.new(permitted_params)
		if @contact.save
			UserMailer.delay.contact_email_to_user(@contact)
			UserMailer.delay.contact_email_to_admin(@contact)
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
