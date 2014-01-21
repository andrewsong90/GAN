class Contact < ActiveRecord::Base

	apply_simple_captcha

	validates_presence_of :title, :message => "can't be blank"
	validates_presence_of :from_email, :message => "can't be blank"
	validates_presence_of :content,  :message => "can't be blank"
end
