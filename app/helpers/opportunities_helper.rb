module OpportunitiesHelper

	def add_asset_link(name) 
		link_to_function(name,nil) do |page|
			page.alert("Hello world!")
			# page.insert_html :bottom, :assets, :partial => 'opportunities/shared/upload', :object => Upload.new
		end
	end

end