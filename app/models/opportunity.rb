class Opportunity < ActiveRecord::Base

	has_many :opportunity_skills
	has_many :skills, :through => :opportunity_skills, dependent: :destroy

	# Association with opportunity timea
	has_many :opportunity_times

	belongs_to :user
	has_many :applications, dependent: :destroy

	# Paperclip attachment configuration. Custom path for the uploaded files to ensure security (instead of making these public)
	has_attached_file :upload, :styles => {:medium => "300x300>"}, :default_url => "/images/:style/missing.png"

	# Multiple uploads
	has_many :uploads
	accepts_nested_attributes_for :uploads, :reject_if => :all_blank, :allow_destroy => true

	# Sponsors
	has_many :sponsors
	accepts_nested_attributes_for :sponsors, :reject_if => :all_blank, :allow_destroy => true

	# Geocoder for storing location
	geocoded_by :location
	after_validation :geocode

	#Validation
	validates_presence_of :title, :message => "Title cannot be blank"
	validates_presence_of :company, :message => "Company cannot be blank"

	validates_attachment_size :upload, :less_than => 1.megabytes

	#Pagination
	paginates_per 10

	#Configuration for database search
	include PgSearch
	pg_search_scope :search, against: [:title, :description]


	# Create opportunity. Removed from the controller for clarity purpose
	def self.create_opportunity(user_id,params)
		o=Opportunity.new
		o.user_id=user_id
		logger.debug("PARAMS, #{params}")
		o.title=params["opportunity"][:title]
		o.location=params[:opportunity][:location]
		o.description=params[:opportunity][:description]
		o.upload=params[:opportunity][:upload]
		o.company=params[:opportunity][:company]
		o.job_type=params[:opportunity][:job_type]
		return o
	end

	#Database Search
	def self.text_search(query)
		if query.present?
			search(query)
		else
			scoped
		end
	end

	#Export to CSV
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |opportunity|
				csv << opportunity.attributes.values_at(*column_names)
			end
		end
	end
	
end
