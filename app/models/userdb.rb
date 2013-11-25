class Userdb < ActiveRecord::Base

	#Importing CSV data
	#:col_sep => "\t" for tab-separated file
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			user_record = find_by_id(row["id"]) || new
			
			raw_params = row.to_hash.slice("fname","lname","classyear","parent_email")
			
			#only hack I could think of at this point
			userdb_params = ActionController::Parameters.new(raw_params)
			user_record.update_attributes(userdb_params.permit(:fname,:lname,:classyear,:parent_email))
			user_record.save!
		end
	end

	# Does the record exist in the database?
	def self.compare_alum_db(params)
		if self.where(:parent_email =>params[:user][:parent_email], :classyear => params[:user][:classyear]).first
			true
		else
			false
		end
	end
end
