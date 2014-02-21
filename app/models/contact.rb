class Contact < ActiveRecord::Base

	validates_presence_of :title, :message => "can't be blank"
	validates_presence_of :from_email, :message => "can't be blank"
	validates_presence_of :content,  :message => "can't be blank"

	def self.categories
		categories=Array.new
		categories.append('Feedback about the platform')
		categories.append('Inviting others')
		categories
	end
end
