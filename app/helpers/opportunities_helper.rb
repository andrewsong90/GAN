module OpportunitiesHelper

	def short_location(location)
		temp=location.split(/,/)
		if temp.length > 3
			short_location=temp[temp.length-3..temp.length].join(",")
		else
			short_location=location
		end

		short_location
	end

	def google_map_query(location)
		query=location.split(/ +/).join('+')
		query_link="http://map.google.com/?q="+query+"&z=15"
		query_link
	end

end