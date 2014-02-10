class Application < ActiveRecord::Base

	belongs_to :user
	belongs_to :opportunity

	has_attached_file :upload

	  #Export to CSV
	  def self.to_csv
	    CSV.generate do |csv|
	      features = ["id","Type","Opportunity id","Opportunity title","Company","Applicant id", "Applicant name","Recepient id","Recepient name", "Sent date", "message"]
	      csv << features
	      all.each do |application|
	      	row=Array.new
			row.append(application.id)
			row.append(application.opportunity.job_type)
			row.append(application.opportunity.id)
			row.append(application.opportunity.title)
			row.append(application.opportunity.company)
			row.append(application.user.id)
			row.append(application.user.full_name)
			row.append(application.opportunity.user.id)
			row.append(application.opportunity.user.full_name)
			row.append(application.created_at)
			row.append(application.message)

			csv << row
	      end
	    end
	  end


end
