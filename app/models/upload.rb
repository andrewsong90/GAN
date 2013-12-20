class Upload < ActiveRecord::Base
	has_attached_file :avatar, :default_url => "/images/:style/missing.png",
				:url => "/opportunities/:opportunity_id/download/:id",
				:path => ":rails_root/uploads/:class/:opportunity_id/:basename.:extension"

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
