class Contact < ActiveRecord::Base

	validates_presence_of :title, :message => "can't be blank"
	validates_presence_of :from_email, :message => "can't be blank"
	validates_presence_of :content,  :message => "can't be blank"

	def self.categories
		categories=Array.new
		categories.append('Feedback about the site')
		categories.append('Difficulties loggin in')
		categories.append('Difficulties navigating within the site')
		categories.append('Inviting others')
		categories.append('Other')
		categories
	end
end
