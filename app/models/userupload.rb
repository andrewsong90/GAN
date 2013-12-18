class Userupload < ActiveRecord::Base

	has_attached_file :avatar, :styles => {:medium => "300x300>"}, :default_url => "/images/:style/missing.png",
				:url => "/users/:user_id/download/:id",
				:path => ":rails_root/user_uploads/:class/:user_id/:basename.:extension"

	belongs_to :user
end
