class ChangeTypeToJobTyp < ActiveRecord::Migration
  def self.up
  	rename_table :types, :jobtypes
  end

  def self.down
  	rename_table :jobtypes, :types
  end
end
