class AddMoreToOpportunity < ActiveRecord::Migration
  def self.up
  	add_column :opportunities, :edu_level, :string
  end

  def self.down
  	remove_column :opportunities, :edu_level
  end
end
