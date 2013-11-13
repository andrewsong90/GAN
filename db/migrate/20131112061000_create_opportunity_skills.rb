class CreateOpportunitySkills < ActiveRecord::Migration
  def change
    create_table :opportunity_skills do |t|

      t.timestamps
    end
  end
end
