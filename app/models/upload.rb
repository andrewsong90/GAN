class Upload < ActiveRecord::Base
	has_attached_file :avatar, :styles => {:medium => "300x300>"}, :default_url => "/images/:style/missing.png"
	belongs_to :user
	belongs_to :opportunity

	# Clarify the filename for displaying
	def self.clarify_name(filename)
		name=File.basename(filename)
		if name == "missing.png"
			nil
		else
			name
		end
	end
end
