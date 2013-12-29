class ContactsController < ApplicationController

	def new
		@contact=Contact.new
	end

	def create
		@contact=Contact.new(permitted_params)
		if @contact.save
			UserMailer.contact_email(@contact).deliver
			redirect_to new_contact_path
		else
			render 'new'	
		end
	end

	private

	def permitted_params
		params.require(:contact).permit(:title,:from_email,:content)
	end

end
