class RenameTypeOpportunities < ActiveRecord::Migration
  def self.up
  	rename_column :opportunities, :type, :job_type
  end
end
