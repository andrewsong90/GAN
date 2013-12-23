class AddActivetoOpportunity < ActiveRecord::Migration
  def self.up
  	add_column :opportunities, :active, :boolean
  
  	Opportunity.update_all(:active => true)
  end

  def self.down
  	remove_column :opportunities, :active
  end
  
end
