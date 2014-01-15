class Friend < User
	
	def self.import(file)
		list_of_users = Array.new
		CSV.foreach(file.path, headers: true) do |row|
			invite_params = row.to_hash.slice("first_name","last_name","email")
			list_of_users.append(invite_params)
		end

		list_of_users
	end

end
