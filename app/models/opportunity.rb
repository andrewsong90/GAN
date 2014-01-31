class Opportunity < ActiveRecord::Base

	has_many :opportunity_skills, dependent: :destroy
	has_many :skills, :through => :opportunity_skills
	accepts_nested_attributes_for :opportunity_skills, :allow_destroy => true

	# Association with opportunity timea
	has_many :opportunity_times

	belongs_to :user
	has_many :applications, dependent: :destroy

	# Paperclip attachment configuration. Custom path for the uploaded files to ensure security (instead of making these public)
	has_attached_file :upload, :styles => {:medium => "200x200>", :thumb => "120x120>"}, :default_url => "/images/opportunity/:style/missing.jpg"

	# Multiple uploads
	has_many :uploads
	accepts_nested_attributes_for :uploads, :reject_if => :all_blank, :allow_destroy => true

	# Sponsors
	has_many :sponsors
	accepts_nested_attributes_for :sponsors, :reject_if => :all_blank, :allow_destroy => true

	has_many :favorite_opportunities, :dependent => :destroy
	
	# Geocoder for storing location
	geocoded_by :location
	after_validation :geocode

	#Validation
	validates_presence_of :title, :message => "cannot be blank"
	validates_presence_of :job_type, :message => "must be selected"
	validates_presence_of :description, :message => "cannot be blank"

	validates_attachment_size :upload, :less_than => 1.megabytes

	#Pagination
	paginates_per 10

	#Configuration for database search
	include PgSearch
	pg_search_scope :search_opportunity, 
					:against => [:title, :description, :location, :company],
					:associated_against => {:user => [:fname, :lname]},
					:using => {
						:tsearch => {:prefix => true}
					}

	pg_search_scope :search_jobtype,
					:against => [:job_type]

	pg_search_scope :search_title,
					:against => [:title],
					:using => {
						:tsearch => {:prefix => true}
					}

	pg_search_scope :search_description,
					:against => [:description],
					:using => {
						:tsearch => {:prefix => true}
					}


	# Check if the opportunity is currently active
	def is_active?
		active
	end

	# Check if the opportunity is among the user's favorite opportunities
	def is_favorite? (user_id)
		self.favorite_opportunities.find_by user_id: user_id
	end

	# Create opportunity. Removed from the controller for clarity purpose
	def self.create_opportunity(user_id,params)
		o=Opportunity.new
		o.user_id=user_id
		o.title=params["opportunity"][:title]
		o.location=params[:opportunity][:location]
		o.description=params[:opportunity][:description]
		o.upload=params[:opportunity][:upload]
		o.company=params[:opportunity][:company]
		o.job_type=params[:opportunity][:job_type]
		return o
	end

	#Database Search
	def self.text_search(params)
		if params[:query].present?
			if params[:job_type].present?
				search_jobtype(params[:job_type]).search_opportunity(params[:query]).reorder("created_at DESC")
			else
				search_opportunity(params[:query])
			end
			# search_opportunity(params[:query])#.reorder("created_at DESC")
		else
			if params[:job_type].present?
				search_jobtype(params[:job_type])
			else
				all
			end
		end
	end

	# Search opportunities by types
	def self.type_search (opportunities, type_ids)
		if  type_ids != nil and type_ids.length != 0
			filtered_opportunities=Array.new
			type_ids.each do |type_id|
				type=Jobtype.where(:id => type_id).first.name
				filtered_opportunities.append(opportunities.select {|opportunity| opportunity.job_type == type })
			end
			filtered_opportunities
		else
			opportunities
		end
	end

	#Export to CSV
	def self.to_csv
		CSV.generate do |csv|
			features=["id","activ","title","company","job_type","description","location","created on","updated on","provider","provider id"]
			csv << features
			all.each do |opportunity|
				
				# Appending rows to csv files
				row=Array.new
				row.append(opportunity.id)
				row.append(opportunity.active)
				row.append(opportunity.title)
				row.append(opportunity.company)
				row.append(opportunity.job_type)
				row.append(ActionView::Base.full_sanitizer.sanitize(opportunity.description))
				row.append(opportunity.location)
				row.append(opportunity.created_at)
				row.append(opportunity.updated_at)
				row.append(opportunity.user.full_name)
				row.append(opportunity.user.id)
				
				csv << row
			end
		end
	end
	
end
