class AssociationsUsersSkills < ActiveRecord::Migration
  def change

  	create_table :users_skills do |t|
  		t.belongs_to :user
  		t.belongs_to :skill
  	end
  end
end
