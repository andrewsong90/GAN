class AddAttrtoUploads < ActiveRecord::Migration
  def self.up
  	add_column :uploads, :opportunity_id, :integer
  end

  def self.down
  	remove_column :uploads, :opportunity_id
  end
end
