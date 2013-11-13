class AddAssociationstoOpportunitySkills < ActiveRecord::Migration
  def change
  	add_column :opportunity_skills, :opportunity_id, :integer
  	add_column :opportunity_skills, :skill_id, :integer
  end
end
