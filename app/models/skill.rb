class Skill < ActiveRecord::Base

	has_many :opportunity_skills, :dependent => :destroy
	has_many :opportunities, :through => :opportunity_skills

	has_many :user_skills, :dependent => :destroy
	has_many :users, :through => :user_skills

	def self.sort_alpha(skills)
		sorted=skills.sort_by! {|s| s.skill}
		half_mark=(sorted.size+1)/2
		first_half=sorted[0..half_mark-1]
		second_half=sorted[half_mark..sorted.size-1]

		new_sorted=Array.new
		for i in 0..first_half.size
			if !first_half[i].nil?
				new_sorted.append(first_half[i])
			end

			if !second_half[i].nil?
				new_sorted.append(second_half[i])
			end
		end

		new_sorted
	end
end
