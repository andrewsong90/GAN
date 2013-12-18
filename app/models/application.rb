class Application < ActiveRecord::Base

	belongs_to :user
	belongs_to :opportunity

	has_attached_file :upload

end
