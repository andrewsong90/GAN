#Interpolation for paperclip saving path. Check custom storage path in upload.rb or userupload.rb
Paperclip.interpolates(:opportunity_id) do |attachment,style|
	attachment.instance.opportunity.id
end

Paperclip.interpolates(:user_id) do |attachment,style|
	attachment.instance.user.id
end