class AddAttributesToOpportunities < ActiveRecord::Migration
  def self.up
  	add_column :opportunities, :title, :string
  	add_column :opportunities, :content, :text
  	add_column :opportunities, :location, :string
  	add_column :opportunities, :type, :string
  end

  def self.down
  	remove_column :opportunities, :title
  	remove_column :opportunities, :content
  	remove_column :opportunities, :location
  	remove_column :opportunities, :type
  end
end
