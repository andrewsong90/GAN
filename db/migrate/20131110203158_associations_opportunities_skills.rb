class AssociationsOpportunitiesSkills < ActiveRecord::Migration
  def change

  	create_table :opportunities_skills do |t|
  		t.belongs_to :opportunity
  		t.belongs_to :skill
  	end
  end
end
