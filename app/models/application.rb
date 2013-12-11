class Application < ActiveRecord::Base

	belongs_to :user
	belongs_to :opportunity

	has_attached_file :upload

	include Rails.application.routes.url_helpers

	# JQuery uploader in conjunction with paperclip
	def to_jq_upload
	{
		"name" => read_attribute(:upload_file_name),
		"size" => read_attribute(:upload_file_size),
		"url" => upload.url(:original),
		"delete_url" => upload_path(self),
		"delete_type" => "DELETE"
	}
	end
end
